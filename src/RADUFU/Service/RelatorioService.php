<?php 
namespace RADUFU\Service;
use \FPDI,
	RADUFU\DAO\Factory,
	RADUFU\DAO\postgres\ProfessorDAO,
    RADUFU\Service\ProfessorService,
  # RADUFU\Service\ComprovanteService;
    RADUFU\Service\AtividadeService,
    RADUFU\Service\TipoService,
    RADUFU\Model\Professor,
    RADUFU\Model\Relatorio,
    RADUFU\Relatorio\PDF,
    RADUFU\Service\CategoriaService;
require_once(__DIR__.'/../Autoloader.php');
require_once(__DIR__.'/Relatorio/src/FPDI-1.4.3/fpdi.php');
#require_once(__DIR__ . '/../../../Relatorio/src/FPDI-1.4.3/fpdi.php');

class RelatorioService extends FPDI{
	private $pdf;
	private $relatorio;
	private $prof; #Professor que requisitou o relatorio
	private $profServ;
	private $ativServ;
	private $relatorioService;
    private $pontuacaoDeReferencia;
    private $limitacaoDeEnsino;
	private $atividades; #atividades do professor entre as datas
	private $ativPeriodos; #Array de array. um array de periodos onde para cada periodo temos um arrray com as atividades presentes nele
    #private $inicio; #Data de inicio
    #private $fim; #Data de fim
    #private $periodos; #Array com (id,periodo), para saber todos os periodos das atividades
    #private $tipos; #Array com (id,descricao) de todos os tipos de atividades presentes
    #private $categoria; #Array com todas as categorias presentes

	#private $dao;
	#private $obj;

	public function GetEntreDatas ($id,$start, $end){
		# Argumentos: Data inicial e final
		# Saida: Um array de atividades, sendo estas todas aquelas ministradas pelo professor entre as datas
		
	}

	public function GetPeriodos ($atividades){
		#Argumentos: Array de atividades
		#Processamento: Varrer o Array e ver quais sao os periodos envolvidos
		#Saida: Array com os periodos encontrados (id, periodo)
	}

	public function GetTiposCategorias ($atividades){
		#Argumentos: Array de atividades
		#Processamento: Varrer o Array e ver quais sao os tipos e categorias das atividades envolvidas
		#Saida: Array com os todos os tipos encontrados (id, descricao, categoria)
	}

	public function GetProf($id)
	{
		#Argumentos: Id do professor
		#Saida: Objeto professor
		$profServ = new ProfessorService();
		return $profServ->get($id);
	}

    /**
     * @method GET
     * @provides application/json
     * @json
     * @param int $idProfessor
     * @return Tonic\Response
     */
    public function __construct()
        {
           $this->pdf = new FPDI("P","cm","A4");
           $this->atividades = array();
           $this->ativPeriodos = array();
           $this->atividadeService = new atividadeService();
           $this->prof = new Professor();
           $this->pontuacaoDeReferencia = 132;
           $this->limitacaoDeEnsino = 100;
        }

    public function GerarRelatorio($id){
        /*
        Entrada: A definir (professor, inicio, fim, classe, nivel)
        Processo:
        0. "Preencher" as variaveis da classe 
        1. PrimeiraPagina()
        2. para cada periodo:
        3.      QuadroPontuacao()
        4.      RelatorioAtividade()
        5. Certificados()
        Saida: Nada, ira apenas gerar o relatorio
        */

        #Preenchendo as variaveis da classe
        $this->prof = $this->GetProf($id);
        $this->atividades = $this->atividadeService->getEntreDatas($this->prof->getId(),'2010-10-2','2016-10-2');
        $this->PeriodosAtividades();

        $this->relatorio = new Relatorio("P","cm","A4");
        $this->relatorio->SetMargins(3,1.5,2);
		$this->relatorio->AliasNbPages();
		$this->PrimeiraPagina();

		foreach ($this->ativPeriodos as $periodo => $ativs) {
			$this->QuadroPontuacao($periodo);
			$this->RelatorioAtividade($periodo);
		}

		$this->relatorio->Output('nome12.pdf','F');

    }

    public function PrimeiraPagina()
    {
        /*
        Entrada: Atividaes e datas de inicio e fim
        Processo:
            1. Construir o Cabecalho da pagina - OK
            2. Para cada periodo em atividades
            3.     BE[periodo] = CalcularBrutoEnsino($atividades)
            4.     LE[periodo] = CalcularLimitadoEnsino($atividades)
            5.     O[periodo] = CalcularOutrasAtividades($atividades)
            6.     BT = BE[periodo] + O[periodo]
            7.     LT = LE[periodo] + O[periodo]
            8. Imprimir Pontos de Referencia
            9. Imprimir Media = ?
            10. Imprimir Limiração de ensino = max(LE)
        Saida: Constroi a primeira pagina do PDF
        */
	    $this->relatorio->AddPage();
	    #-- Cabeçalho
	        $this->relatorio->SetFont('Times','B',16);
	        $this->relatorio->MultiCell(0,0.4,utf8_decode('Quadro Geral de Pontução'));
	        $this->relatorio->SetFont('Times','B',12);
	        $this->relatorio->Cell(1.25,0.5,'',0,0,'C',0);
	        $this->relatorio->Cell(2,0.4,'Professor: ');
	        $this->relatorio->SetFont('Times','',12);
	        $this->relatorio->Cell(0,0.4,utf8_decode($this->prof->getNome()));
	        $this->relatorio->SetFont('Times','B',12);
	        $this->relatorio->Ln(1);
	    #-- Construindo a tabela
		    #--- Cabecalho da tabela
		        $this->relatorio->SetFillColor(200,200,200);
		        $this->relatorio->Cell(2.5,0.5,'',0,0,'C',0);//espaco em branco
		        $this->relatorio->Cell(5,0.5,'Ensino',1,0,'C',1);
		        $this->relatorio->Cell(4,1,'Outras atividades',1,0,'C',1);
		        $this->relatorio->Cell(5,0.5,'Total',1,0,'C',1);
		        $this->relatorio->Cell(4,0.5,'',0,0,'C',0);
		        $this->relatorio->Ln(0.5);
		        $this->relatorio->Cell(2.5,0.5,utf8_decode('Período'),1,0,'C',1);
		        $this->relatorio->Cell(2.5,0.5,'Bruto',1,0,'C',1);
		        $this->relatorio->Cell(2.5,0.5,'Limitado',1,0,'C',1);
		        $this->relatorio->Cell(4,0.5,'',0,0,'C',0);
		        $this->relatorio->Cell(2.5,0.5,'Bruto',1,0,'C',1);
		        $this->relatorio->Cell(2.5,0.5,'Limitado',1,0,'C',1);
		        $this->relatorio->Ln();
		    #--- Construindo o resto
		        $TotalLT = 0;
		        foreach ($this->ativPeriodos as $periodo => $ativs)
		        {
		        	$BE = $this->CalcularBrutoEnsino($ativs);
		        	$LE = $this->CalcularLimitadoEnsino($ativs);
		        	$O = $this->CalcularOutrasAtividades($ativs);
			        $BT = $BE+$O;
		        	$LT = $LE+$O;
		        	$TotalLT += $LT;		
				    for($j = 0; $j<6; $j++)
			            {
			            	switch ($j) {
			            		case 0:
			            			$this->relatorio->Cell(2.5,0.5,$periodo,1,0,'C',1);
			            			break;
		            			
		            			case 1:
		            				$this->relatorio->Cell(2.5,0.5,$BE + 10,1,0,'C');
		            				break;
		            			
		            			case 2:
		            				$this->relatorio->Cell(2.5,0.5,$LE,1,0,'C');
		            				break;
		            			
		            			case 3:
		            				$this->relatorio->Cell(4,0.5,$O,1,0,'C');
		            				break;
		            			
		            			case 4:
		            				$this->relatorio->Cell(2.5,0.5,$BT,1,0,'C');
		            				break;

		            			case 5:
		            				$this->relatorio->Cell(2.5,0.5,$LT,1,0,'C');
		            				break;
			            		}
			    		}
		        	$this->relatorio->Ln();
		        }
	    #--- Parte Final
        $this->relatorio->Cell(11.5,0.5,'',0,0,'C',0);//espaco em branco
        $this->relatorio->Cell(2.5,0.5,'Media:',0,0,'C',0);
        $this->relatorio->Cell(2.5,0.5,$TotalLT/count($this->ativPeriodos),1,0,'C');
        $this->relatorio->Ln();
        $this->relatorio->Cell(4,0.5,utf8_decode('Pontos de referência'),1,0,'C',1);
        $this->relatorio->Cell(4,0.5,$this->pontuacaoDeReferencia,1,0,'C');
        $this->relatorio->Ln();
        $this->relatorio->Cell(4,0.5,utf8_decode('Limitação de ensino'),1,0,'C',1);
        $this->relatorio->Cell(4,0.5,$this->limitacaoDeEnsino,1,0,'C');
        $this->relatorio->Ln();    
    }

    public function QuadroPontuacao($periodo){
        /*
        Entrada: Periodo, atividades, Tipos
        Processo: Constroi o quadro de pontuacao do periodo com todas as descricoes dos tipos das atividades que aparecem no mesmo juntamente com o item ao qual pertencem, quantidade, pontos e Documento Pag.
        Saida: Nada, ira apenas gerar a tabela para o FPDF
        */
        $this->relatorio->AddPage();
    #-- Cabeçalho
        $this->relatorio->SetFont('Times','B',16);
        $this->relatorio->MultiCell(0,0.4,utf8_decode('Quadro de Pontução de ').$periodo);
        $this->relatorio->SetFont('Times','B',12);
        $this->relatorio->Cell(1.25,0.5,'',0,0,'C',0);
        $this->relatorio->Cell(2,0.4,'Professor: ');
        $this->relatorio->SetFont('Times','',12);
        $this->relatorio->Cell(0,0.4,utf8_decode($this->prof->getNome()));
        $this->relatorio->SetFont('Times','B',12);
        $this->relatorio->Ln(1);
	#-- Tabela
		#--- Cabeçalho da tabela
        $this->relatorio->Cell(1.5,0.5,'Item',1,0,'C',1);
        $this->relatorio->Cell(1.5,0.5,'Qtd',1,0,'C',1); 
        $this->relatorio->Cell(9,0.5,utf8_decode('Descrição da atividade'),1,0,'C',1);      
        $this->relatorio->Cell(2,0.5,'Pontos',1,0,'C',1);
        $this->relatorio->Cell(3,0.5,'Documento Pag.',1,0,'C',1);
        $this->relatorio->SetFont('Times','',12);
        $this->relatorio->Ln();

        $this->relatorio->SetWidths(array(1.5,1.5,9,2,3));

        $texto = 'Disciplina INF13: Organização de Computadores 2 ';
        $texto0 = 'Disciplina GSI001: Empreendedorismo em Informática';  
        $texto1 = 'Publicação de trabalho completo em anais de reunião científica nacional, com corpo de revisores.';        
        $texto2 = 'Membro titular de banca de defesa de projetos,estágio supervisionado e de monografias de graduação';       
        $texto3 = 'Publicação de trabalho completo em anais de reunião científica internacional, com corpo de revisores ';
        
        $texto = array();
        $texto[0] = utf8_decode($texto0);
        $texto[1] = utf8_decode($texto1);
        $texto[2] = utf8_decode($texto2);
        $texto[3] = utf8_decode($texto3);
   		#--- Tabela em si
        for($i=0;$i<20;$i++)
        	{
        		
        		$this->relatorio->Row(array($i,$i,$texto[$i%4],$i,$i));
        	}
    #-- Resumo das Atividades
        $this->relatorio->Ln();
        $this->relatorio->Cell(1.25,0.5,'',0,0,'C',0);
        $this->relatorio->SetFont('Times','B',14);
        $this->relatorio->MultiCell(0,0.4,'Resumo das atividades');
        $this->relatorio->Ln();
        $this->relatorio->SetFont('Times','B',12);
        $this->relatorio->Cell(5.5,0.5,'Ensino',1,0,'C',1);
        $this->relatorio->Cell(5.5,0.5,'Demais Atividades',1,0,'C',1);
        $this->relatorio->Cell(5.5,0.5,'Total',1,0,'C',1);
        $this->relatorio->Ln();
        $this->relatorio->SetFont('Times','',12);
        $this->relatorio->Cell(5.5,0.5,'142.3',1,0,'C');
        $this->relatorio->Cell(5.5,0.5,'13443',1,0,'C');
        $this->relatorio->Cell(5.5,0.5,'24142.4',1,0,'C');
        $this->relatorio->Ln();            
    }

    public function RelatorioAtividade($periodo){
        /*
        Entrada: Periodo, atividades, categoria
        Processo: 
            1. Cria o cabecalho da pagina
            2. Para cada Categoria
            3.      Imprime o nome seguido do total de pontos
            4.      para cada atividade da categoria
            5.          imprime a descricao
        Saida: Nada, apenas ira gerar o relatorio de atividade do periodo em questao para o fdpf
        */
        $this->relatorio->AddPage();
    #-- Cabeçalho
        $this->relatorio->SetFont('Times','B',16);
        $this->relatorio->MultiCell(0,0.4,utf8_decode('Relatório de Atividades'));
        $this->relatorio->SetFont('Times','B',12);
        $this->relatorio->Cell(1.25,0.5,'',0,0,'C',0);
        $this->relatorio->Cell(2,0.4,utf8_decode('Período: '));
        $this->relatorio->SetFont('Times','',12);
        $this->relatorio->Cell(0,0.4,$periodo);
        $this->relatorio->Ln();
        $this->relatorio->SetFont('Times','B',12);
        $this->relatorio->Cell(1.25,0.5,'',0,0,'C',0);
        $this->relatorio->Cell(2,0.4,'Professor: ');
        $this->relatorio->SetFont('Times','',12);
        $this->relatorio->Cell(0,0.4,utf8_decode($this->prof->getNome()));
        $this->relatorio->SetFont('Times','B',12);
        $this->relatorio->Ln(1);
    #-- Tipos de atividades
        //5: Atividade de Ensino, Atividade de Orientação, Produção bibliográfica, Produção Técnica, Outras Atividades.
        $this->relatorio->Ln();
        //Caso haja mais de 5 tipos de atividade basta colocar um for aqui!
        $atividades = array();
        $atividades[0]=utf8_decode('Atividades de Ensino');
        $atividades[1]=utf8_decode('Atividades de Orientação');
        $atividades[2]=utf8_decode('Produção bibliográfica');
        $atividades[3]=utf8_decode('Produção Técnica');
        $atividades[4]=utf8_decode('Outras atividades');

        $pontos = array();
        $pontos[0] = 1234;
        $pontos[1] = 134;
        $pontos[2] = 234;
        $pontos[3] = 125;
        $pontos[4] = 834;

        $bullets = array();
        $bullets[0] = chr(127);
        $bullets[1] = chr(155);
        $bullets[2] = chr(187);
        $bullets[3] = chr(186);
        $bullets[4] = chr(185);
        $bullets[5] = chr(183);
        $bullets[6] = chr(176);

        for($i = 0; $i<5;$i++)
        {
        $nivel = 0;        
        //Nivel 0:
        $this->relatorio->SetFont('Times','',14);
        $this->relatorio->Cell(6.5,0.4,$bullets[$nivel].' '.$atividades[$i].': '.$pontos[$i].' pontos');
        $this->relatorio->Ln(1);

        $this->relatorio->SetFont('Times','',12);
        $nivel = 1;
        //Nivel 1:
            for ($j=0; $j < 3; $j++) { 
                $this->relatorio->Cell(1 * $nivel,0.5,'',0,0,'C',0);
                $this->relatorio->Cell(6.5,0.4,$bullets[$nivel].utf8_decode(' Disciplinas no Curso de Bacharelado de Ciência da Computação ').$nivel);
                $this->relatorio->Ln(1);

                $nivel ++ ;

                for ($k=0; $k <3 ; $k++) { 
                      #  $this->relatorio->Cell(1 * $nivel,0.5,'',0,0,'C',0);
                      #  $this->relatorio->Cell(6.5,0.4,$bullets[$nivel].utf8_decode(' Isto é um texto de nível ').$nivel);
                      #  $this->relatorio->Ln(1);
                }

                $nivel --;

            }
        $nivel --;
        #$this->relatorio->SetFont('Times','',12);
        #$this->relatorio->Cell(0,0.4,$pontos[$i].' pontos',0,0,'L',0);                

        }        
    }

    # Anexa ao fim do documento os certificados das atividades
    public function Certificados(){

    }

    # Coloca o valor correto na variavel PontuacaoDeReferencia de acordo com a classe e o nivel
    public function CalculaPontuacao($classe, $nivel){

    }

#---------------------- FUNCOES AUXILIARES ----------------------#
    public function PeriodosAtividades()
	    {
	    	$ano = '';
	    	$periodo = '';
	    	#iniciando todas as possiveis entradas ao dicionario
	    	foreach ($this->atividades as $ativ) {
	    		$data_i = explode("/",$ativ->getDataInicio());
	    		$ano = $data_i[2];
	    		$periodo = ((int)$data_i[1]<7)?'1':'2';
	    		
	    		$periodo2 = ($periodo == '1') ? '2':'1';
	    		$ano2 = ((int)$ano - 1).'';
	    		$ano2 =  ($periodo2 == '1') ? ($ano) : ($ano2);
		
	    		$this->ativPeriodos[$ano2.'-'.$periodo2] = array();
	    		$this->ativPeriodos[$ano.'-'.$periodo] = array();
	    	}
	    	#adicionando as atividades ao dicionario
	    	foreach ($this->atividades as $ativ) {
	    		$data_i = explode("/",$ativ->getDataInicio());
	    		$ano = $data_i[2];
	    		$periodo = ((int)$data_i[1]<7)?'1':'2';
				#tratando a greve
	    		if (2012 == (int)$data_i[2])
		    		{
		    			$ano = '2012';
		 	   			$periodo = ((int)$data_i[1] < 10)? '1' : '2';
		 	   		}	
	 	   		elseif (2013 == (int)$data_i[2])
		 	   		{
		 	   			if ((int)$data_i<5)
			 	   			{
			 	   				$ano = '2012';
			 	   				$periodo = '2';
			 	   			}
		 	   			elseif((int)$data_i < 11)
			 	   			{
			 	   				$ano = '2013';
			 	   				$periodo = '1';
			 	   			}
		 	   			else
			 	   			{
			 	   				$ano = '2013';
			 	   				$periodo = '2';	
			 	   			}
		 	   		}
	 	   		elseif(2014 == (int)$data_i[2])
		    		{
		    			if ((int)$data_i<3)
			 	   			{
			 	   				$ano = '2013';
			 	   				$periodo = '1';
			 	   			}
		 	   			elseif((int)$data_i < 8)
			 	   			{
			 	   				$ano = '2014';
			 	   				$periodo = '1';
			 	   			}
		 	   			else
			 	   			{
			 	   				$ano = '2014';
			 	   				$periodo = '2';	
			 	   			}
		    		}
		    	$per = $ano.'-'.$periodo;		
				$this->ativPeriodos[$per][] = $ativ;	    	
	    	}
	    	#limpando as partes vazias do dicionario
	    	foreach ($this->ativPeriodos as $key => $ativs) {
	    		if(count($ativs) == 0)
	    			{
	    				unset($this->ativPeriodos[$key]);
	    			}
	    	}
	    }

    private function CalcularBrutoEnsino(array $ativs)
	    {
	    	return 15;
	    }

    private function CalcularLimitadoEnsino(array $ativs)
    	{
    		return 12;
    	}

    private function CalcularOutrasAtividades(array $ativs)
    	{
    		return 12313;
    	}
	        	
}
?>