<?php
namespace RADUFU\Resource;

use RADUFU\Service\RelatorioService,
    Tonic\Resource,
    Tonic\Response;
/**
 * @uri /relatorio
 * @uri /relatorio/:id
 */
class RelatorioResource extends Resource {
/**
    Esta classe esta destinada a gerar o relatorio final, de acordo com as datas informadas utilizando o framework FPDF e FPDI.
*/
    private $relatorioService = null;
    private $pontuacaoDeReferencia = 0;
    private $prof; #professor que requisita o relatorio
    private $atividades; #atividades do professor entre as datas
    private $inicio; #Data de inicio
    private $fim; #Data de fim
    private $periodos; #Array com (id,periodo), para saber todos os periodos das atividades
    private $tipos; #Array com (id,descricao) de todos os tipos de atividades presentes
    private $categoria; #Array com todas as categorias presentes

    /**
     * @method GET
     * @provides application/json
     * @json
     * @param int $idProfessor
     * @return Tonic\Response
     */
    
    public function GerarRelatorio(){
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
    }

    public function PrimeiraPagina(){
        /*
        Entrada: Atividaes e datas de inicio e fim
        Processo:
            1. Construir o Cabecalho da pagina
            2. Para cara periodo em atividades
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



    /**
     * Transforma as requisições json para array e as repostas array para json
     */
    protected function json() {

        $this->before(function ($request) {
            if ($request->contentType == 'application/json') {
                $request->data = json_decode($request->data);
            }
        });
        #Não necessito da resposta!
        $this->after(function ($response) {
         $response->contentType = 'application/json';
         $response->body = json_encode($response->body);
     });
    }
}

?>