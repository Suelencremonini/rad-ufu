<?php 
namespace RADUFU\Service;

use RADUFU\DAO\Factory,
	RADUFU\DAO\postgres\ProfessorDAO,
    RADUFU\Service\ProfessorService;
  # RADUFU\Service\ComprovanteService;
    RADUFU\Service\AtividadeService;
    RADUFU\Service\TipoService;
    RADUFU\Service\CategoriaService;

class RelatorioService {
	private $prof; #Professor que requisitou o relatorio
	#private $dao;
	#private $obj;

	private function __construct(){ }

	public static function GetBetweenDates ($start, $end){
		# Argumentos: Data inicial e final
		# Saida: Um array de atividades, sendo estas todas aquelas ministradas pelo professor entre as datas
	}

	public static function GetPeriodos ($atividades){
		#Argumentos: Array de atividades
		#Processamento: Varrer o Array e ver quais sao os periodos envolvidos
		#Saida: Array com os periodos encontrados (id, periodo)
	}

	public static function GetTiposCategorias ($atividades){
		#Argumentos: Array de atividades
		#Processamento: Varrer o Array e ver quais sao os tipos e categorias das atividades envolvidas
		#Saida: Array com os todos os tipos encontrados (id, descricao, categoria)
	}	

}

?>