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
public function __construct()
        {
            #$this->prof = new Professor();
            #$this->atividades = array();
            #$this->relatorioService = new RelatorioService();
            $this->relatorioService = new RelatorioService();
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