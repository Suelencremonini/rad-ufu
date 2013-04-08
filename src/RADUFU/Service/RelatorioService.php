<?php 
namespace RADUFU\Service;
use RADUFU\DAO\Factory,
	RADUFU\DAO\postgres\ProfessorDAO,
    RADUFU\Service\ProfessorService,
  # RADUFU\Service\ComprovanteService;
    RADUFU\Service\AtividadeService,
    RADUFU\Service\TipoService,
    RADUFU\Service\CategoriaService;
require_once(__DIR__.'/../Autoloader.php');
require_once(__DIR__.'/Relatorio/src/FPDI-1.4.3/fpdi.php');
#require_once(__DIR__ . '/../../../Relatorio/src/FPDI-1.4.3/fpdi.php');

class RelatorioService extends FPDI{
	private $prof; #Professor que requisitou o relatorio
	private $profServ;
	private $ativServ;
	private $relatorioService;
    #rivate $pontuacaoDeReferencia = 0;
	private $atividades; #atividades do professor entre as datas
    #private $inicio; #Data de inicio
    #private $fim; #Data de fim
    #private $periodos; #Array com (id,periodo), para saber todos os periodos das atividades
    #private $tipos; #Array com (id,descricao) de todos os tipos de atividades presentes
    #private $categoria; #Array com todas as categorias presentes

	#private $dao;
	#private $obj;

//-------------------------------------------------------------
	var $header_flag = true;
	var $footer_flag = true;

	#-- Funcao louca que encontrei
	var $widths;
	var $aligns;

	function SetWidths($w)
		{
		    //Set the array of column widths
		    $this->widths=$w;
		}

	function SetAligns($a)
		{
		    //Set the array of column alignments
		    $this->aligns=$a;
		}

	function Row($data)
		{
		    //Calculate the height of the row
		    $nb=0;
		    for($i=0;$i<count($data);$i++)
		        $nb=max($nb, $this->NbLines($this->widths[$i], $data[$i]));
		    $h=0.5*$nb;
		    //Issue a page break first if needed
		    $this->CheckPageBreak($h);
		    //Draw the cells of the row
		    for($i=0;$i<count($data);$i++)
		    {
		        $w=$this->widths[$i];
		        $tipo = ($i == 2) ? 'J' : 'C';
		        $a=isset($this->aligns[$i]) ? $this->aligns[$i] : $tipo;
		        //Save the current position
		        $x=$this->GetX();
		        $y=$this->GetY();
		        //Draw the border
		        $this->Rect($x, $y, $w, $h);
		        //Print the text
		        $this->MultiCell($w, 0.5, $data[$i], 0, $a);
		        //Put the position to the right of the cell
		        $this->SetXY($x+$w, $y);
		    }
		    //Go to the next line
		    $this->Ln($h);
		}

	function CheckPageBreak($h)
		{
		    //If the height h would cause an overflow, add a new page immediately
		    if($this->GetY()+$h>$this->PageBreakTrigger)
		        $this->AddPage($this->CurOrientation);
		}

	function NbLines($w, $txt)
		{
		    //Computes the number of lines a MultiCell of width w will take
		    $cw=&$this->CurrentFont['cw'];
		    if($w==0)
		        $w=$this->w-$this->rMargin-$this->x;
		    $wmax=($w-2*$this->cMargin)*1000/$this->FontSize;
		    $s=str_replace("\r", '', $txt);
		    $nb=strlen($s);
		    if($nb>0 and $s[$nb-1]=="\n")
		        $nb--;
		    $sep=-1;
		    $i=0;
		    $j=0;
		    $l=0;
		    $nl=1;
		    while($i<$nb)
		    {
		        $c=$s[$i];
		        if($c=="\n")
		        {
		            $i++;
		            $sep=-1;
		            $j=$i;
		            $l=0;
		            $nl++;
		            continue;
		        }
		        if($c==' ')
		            $sep=$i;
		        $l+=$cw[$c];
		        if($l>$wmax)
		        {
		            if($sep==-1)
		            {
		                if($i==$j)
		                    $i++;
		            }
		            else
		                $i=$sep+1;
		            $sep=-1;
		            $j=$i;
		            $l=0;
		            $nl++;
		        }
		        else
		            $i++;
		    }
		    return $nl;
		}

//Page header
    function Header()
    {
    	if ($this->header_flag == 1) {	    	
	        //Logo
	        $this->Image('../img/ufu.jpg',3,1,0.9);
	        //Arial bold 15
	        $this->SetFont('Times','B',12);
	        //Move to the right
	        $this->Cell(3);
	        //Title
	        $this->Cell(10,0,utf8_decode('Universidade Federal de Uberlândia'),0,0,'C');

	        $this->Ln();
	        #$this->Line(3,2.27,19,2.27);
	        $this->SetFont('Arial','',7);

	        $this->Ln(1);
	        #$this->MultiCell(0,0.2,utf8_decode('Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamco'));
	        #$this->cMargin=1;
	        #$this->Cell(0.5,2.7,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamco',0,0); 
	        #$this->Line(3,3.1,19,3.1);
	        //Line break
	        $this->Ln(0.7);
    	}
    }

//Page footer
    function Footer()
    {
    	if ($this->footer_flag)
    	{	
	        //Position at 1.5 cm from bottom
	        $this->SetY(-1.5);
	        //Arial italic 8
	        $this->SetFont('Arial','I',8);
	        //Page number
	        $this->Cell(0,1,utf8_decode('Página ').$this->PageNo().'/{nb}',0,0,'C');
	    }
    }

//--------------------------------------------------------------

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
           $this->atividades = array();
           $this->atividadeService = new atividadeService();
           $this->prof = new Professor();
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
        $this->prof = $this->relatorioService->GetProf($id);
        $this->atividades = $this->atividadeService->getEntreDatas($this->prof->getId(),'2010-10-2','2016-10-2');
        


        foreach ($this->atividades as $ativ) {
            $data_i = explode("/",$ativ->getDataInicio());
            if( $data_i[2] > '2019')
                echo $ativ->getDescricao()." - ".$ativ->getDataInicio()." - ".$ativ->getDataFim()."\n\n\n";
        }

        return $this->prof;

    }

    public function PrimeiraPagina(){
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
    #-- Cabeçalho
        $this->SetFont('Times','B',16);
        $this->MultiCell(0,0.4,utf8_decode('Quadro Geral de Pontução'));
        $this->SetFont('Times','B',12);
        $this->Cell(1.25,0.5,'',0,0,'C',0);
        $this->Cell(2,0.4,'Professor: ');
        $this->SetFont('Times','',12);
        $this->Cell(0,0.4,utf8_decode($this->prof->getNome()));
        $this->SetFont('Times','B',12);
        $this->Ln(1);
    #-- Construindo a tabela
	    #--- Cabecalho da tabela
	        $this->SetFillColor(200,200,200);
	        $this->Cell(2.5,0.5,'',0,0,'C',0);//espaco em branco
	        $this->Cell(5,0.5,'Ensino',1,0,'C',1);
	        $this->Cell(4,1,'Outras atividades',1,0,'C',1);
	        $this->Cell(5,0.5,'Total',1,0,'C',1);
	        $this->Cell(4,0.5,'',0,0,'C',0);
	        $this->Ln(0.5);
	        $this->Cell(2.5,0.5,utf8_decode('Período'),1,0,'C',1);
	        $this->Cell(2.5,0.5,'Bruto',1,0,'C',1);
	        $this->Cell(2.5,0.5,'Limitado',1,0,'C',1);
	        $this->Cell(4,0.5,'',0,0,'C',0);
	        $this->Cell(2.5,0.5,'Bruto',1,0,'C',1);
	        $this->Cell(2.5,0.5,'Limitado',1,0,'C',1);
	        $this->Ln();
	    #--- Construindo o resto

	        while($periodo < $fim)
	        {
	        	$BE = $this->CalcularBrutoEnsino($atividades,$periodo);
	        	$LE = $this->CalcularLimitadoEnsino($atividades,$periodo);
	        	$O = $this->CalcularOutrasAtividades($atividades,$periodo);
		        $BT = $BE+$O;
	        	$LT = $LE+$O;		
			    for($j = 0; $j<6; $j++)
		            {
		            	switch ($j) {
		            		case 0:
		            			$this->Cell(2.5,0.5,$periodo,1,0,'C',1);
		            			break;
	            			
	            			case 1:
	            				$this->Cell(2.5,0.5,$BE,1,0,'C');
	            				break;
	            			
	            			case 2:
	            				$this->Cell(2.5,0.5,$LE,1,0,'C');
	            				break;
	            			
	            			case 3:
	            				$this->Cell(4,0.5,$O,1,0,'C');
	            				break;
	            			
	            			case 4:
	            				$this->Cell(2.5,0.5,$BT,1,0,'C');
	            				break;

	            			case 5:
	            				$this->Cell(2.5,0.5,$LT,1,0,'C');
	            				break;
		            		}
		        	$this->Ln();
		    	}
	        }
    #--- Parte Final
        $this->Cell(11.5,0.5,'',0,0,'C',0);//espaco em branco
        $this->Cell(2.5,0.5,'Media:',0,0,'C',0);
        $this->Cell(2.5,0.5,'1234,34',1,0,'C');
        $this->Ln();
        $this->Cell(4,0.5,utf8_decode('Pontos de referência'),1,0,'C',1);
        $this->Cell(4,0.5,'166',1,0,'C');
        $this->Ln();
        $this->Cell(4,0.5,utf8_decode('Limitação de ensino'),1,0,'C',1);
        $this->Cell(4,0.5,'141,1',1,0,'C');
        $this->Ln();
    
    }

    public function QuadroPontuacao(){
        /*
        Entrada: Periodo, atividades, Tipos
        Processo: Constroi o quadro de pontuacao do periodo com todas as descricoes dos tipos das atividades que aparecem no mesmo juntamente com o item ao qual pertencem, quantidade, pontos e Documento Pag.
        Saida: Nara, ira apenas gerar a tabela para o FPDF
        */
    }

    public function RelatorioAtividade(){
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
    }

    # Anexa ao fim do documento os certificados das atividades
    public function Certificados(){

    }

    # Coloca o valor correto na variavel PontuacaoDeReferencia de acordo com a classe e o nivel
    public function CalculaPontuacao($classe, $nivel){

    }


}

?>