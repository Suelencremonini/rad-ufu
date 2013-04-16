<?php
namespace RADUFU\Resource;

use RADUFU\Service\RelatorioService,
    RADUFU\Service\AtividadeService,
    Tonic\Resource,
    Tonic\Response,
    RADUFU\Model\Professor;
/**
 * @uri /relatorio
 * @uri /relatorio/:id
 */
class RelatorioResource extends Resource {
/**
    Esta classe esta destinada a gerar o relatorio final, de acordo com as datas informadas utilizando o framework FPDF e FPDI.
*/
    private $relatorioService;
    public function __construct()
        {
            #$this->prof = new Professor();
            #$this->atividades = array();
            #$this->relatorioService = new RelatorioService();
            #$this->atividadeService = new atividadeService();
            #$this->prof = new Professor();
        }

    public function GerarRelatorio($id,$dataI,$dataF,$pont_ref,$lim_ensi){
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
        $this->relatorioService = new RelatorioService($id,$dataI,$dataF,$pont_ref,$lim_ensi);
        $this->relatorioService->GerarRelatorio();
    }

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