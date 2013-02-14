<?php
header("Content-type: text/html; charset=utf-8");
require('src/fpdf.php');
#require('tabela.php');

class PDF extends FPDF
{
//Page header
    function Header()
    {
        //Logo
        $this->Image('img/ufu.jpg',3,1,0.9);
        //Arial bold 15
        $this->SetFont('Times','B',12);
        //Move to the right
        $this->Cell(3);
        //Title
        $this->Cell(10,0,utf8_decode('Universidade Federal de Uberlândia'),0,0,'C');

        $this->Ln();
        $this->Line(3,2.27,19,2.27);
        $this->SetFont('Arial','',7);

        $this->Ln(1);
        $this->MultiCell(0,0.2,utf8_decode('Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamco'));
        #$this->cMargin=1;
        #$this->Cell(0.5,2.7,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamco',0,0); 
        $this->Line(3,3.1,19,3.1);
        //Line break
        $this->Ln(0.7);

    }

//Page footer
    function Footer()
    {
        //Position at 1.5 cm from bottom
        $this->SetY(-1.5);
        //Arial italic 8
        $this->SetFont('Arial','I',8);
        //Page number
        $this->Cell(0,1,utf8_decode('Página ').$this->PageNo().'/{nb}',0,0,'C');
    }

// Primeira Pagina: Cabeçalho e Tabela
    function PrimeiraPagina($nome,$periodos)
    {
        #Cabeçalho
        $this->SetFont('Times','B',16);
        $this->MultiCell(0,0.4,utf8_decode('Quadro Geral de Pontução'));
        $this->SetFont('Times','B',12);
        $this->Cell(1.25,0.5,'',0,0,'C',0);
        $this->Cell(2,0.4,'Professor: ');
        $this->SetFont('Times','',12);
        $this->Cell(0,0.4,utf8_decode($nome));
        $this->SetFont('Times','B',12);
        $this->Ln(1);
    #-- Construindo a tabela
        #Cabeçalho da tabela
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
        #Construindo o resto
        for($i = 0; $i < $periodos; $i++)
            {   
                for($j = 0; $j<6; $j++)
                    {
                        if($j==0)
                            {                                
                                $this->Cell(2.5,0.5,'2009-2',1,0,'C',1);    
                            }
                        else if($j==3)
                            {
                                $this->Cell(4,0.5,'1243',1,0,'C');
                            }
                        else
                            {
                                $this->Cell(2.5,0.5,'312',1,0,'C');
                            }    
                    }
                $this->Ln();
            }
            #Parte Final:
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

//Quadro de pontuação por período
    function QuadroPeriodo($nome,$periodo,$atividades)
    {
    #-- Cabeçalho
        $this->SetFont('Times','B',16);
        $this->MultiCell(0,0.4,utf8_decode('Quadro de Pontução de ').$periodo);
        $this->SetFont('Times','B',12);
        $this->Cell(1.25,0.5,'',0,0,'C',0);
        $this->Cell(2,0.4,'Professor: ');
        $this->SetFont('Times','',12);
        $this->Cell(0,0.4,utf8_decode($nome));
        $this->SetFont('Times','B',12);
        $this->Ln(1);
    #-- Tabela
        #Cabeçalho da tabela
        $this->Cell(1.5,0.5,'Item',1,0,'C',1);
        $this->Cell(1.5,0.5,'Qtd',1,0,'C',1);
        $this->Cell(9,0.5,utf8_decode('Descrição da atividade'),1,0,'C',1);
        $this->Cell(2,0.5,'Pontos',1,0,'C',1);
        $this->Cell(3,0.5,'Documento Pag.',1,0,'C',1);
        $this->Ln();

        #Conteudo da tabela
        #$texto = 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamco';
        $texto = 'texto bunitinho';
        $this->SetFont('Times','',12);
        for($i = 0; $i<$atividades;$i++)
            {
               for($j = 0; $j<5;$j++)
               {
                    if($j==0 || $j == 1)
                    {
                        $this->Cell(1.5,0.5,$i,1,0,'C');
                    }
                    else if($j==2)
                    {
                        $this->Cell(9,0.5,utf8_decode($texto),1,0,'J');   
                    }
                    else if($j==3)
                    {
                        $this->Cell(2,0.5,$j*$i,1,0,'C');   
                    }
                    else
                    {
                        $this->Cell(3,0.5,$i+$j,1,0,'C');   
                    }
               }
               $this->Ln(); 
            }
    #-- Resumo das Atividades
        $this->Ln();
        $this->Cell(1.25,0.5,'',0,0,'C',0);
        $this->SetFont('Times','B',14);
        $this->MultiCell(0,0.4,'Resumo das atividades');
        $this->Ln();
        $this->SetFont('Times','B',12);
        $this->Cell(5.5,0.5,'Ensino',1,0,'C',1);
        $this->Cell(5.5,0.5,'Demais Atividades',1,0,'C',1);
        $this->Cell(5.5,0.5,'Total',1,0,'C',1);
        $this->Ln();
        $this->SetFont('Times','',12);
        $this->Cell(5.5,0.5,'142.3',1,0,'C');
        $this->Cell(5.5,0.5,'13443',1,0,'C');
        $this->Cell(5.5,0.5,'24142.4',1,0,'C');
        $this->Ln();
    }

//Relatorio de atividades de um determinado periodo
    function RelatorioAtividade($nome,$periodo)
    {
    #-- Cabeçalho
        $this->SetFont('Times','B',16);
        $this->MultiCell(0,0.4,utf8_decode('Relatório de Atividades'));
        $this->SetFont('Times','B',12);
        $this->Cell(1.25,0.5,'',0,0,'C',0);
        $this->Cell(2,0.4,utf8_decode('Período: '));
        $this->SetFont('Times','',12);
        $this->Cell(0,0.4,$periodo);
        $this->Ln();
        $this->SetFont('Times','B',12);
        $this->Cell(1.25,0.5,'',0,0,'C',0);
        $this->Cell(2,0.4,'Professor: ');
        $this->SetFont('Times','',12);
        $this->Cell(0,0.4,utf8_decode($nome));
        $this->SetFont('Times','B',12);
        $this->Ln(1);
    #-- Tipos de atividades
        //5: Atividade de Ensino, Atividade de Orientação, Produção bibliográfica, Produção Técnica, Outras Atividades.
        $this->Ln();
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
        $this->SetFont('Times','',14);
        $this->Cell(6.5,0.4,$bullets[$nivel].' '.$atividades[$i].': '.$pontos[$i].' pontos');
        $this->Ln(1);

        $this->SetFont('Times','',12);
        $nivel = 1;
        //Nivel 1:
            for ($j=0; $j < 3; $j++) { 
                $this->Cell(1 * $nivel,0.5,'',0,0,'C',0);
                $this->Cell(6.5,0.4,$bullets[$nivel].utf8_decode(' Isto é um texto de nível ').$nivel);
                $this->Ln(1);

                $nivel ++ ;

                for ($k=0; $k <3 ; $k++) { 
                        $this->Cell(1 * $nivel,0.5,'',0,0,'C',0);
                        $this->Cell(6.5,0.4,$bullets[$nivel].utf8_decode(' Isto é um texto de nível ').$nivel);
                        $this->Ln(1);
                }

                $nivel --;

            }
        $nivel --;
        #$this->SetFont('Times','',12);
        #$this->Cell(0,0.4,$pontos[$i].' pontos',0,0,'L',0);                

        }        
        
    }
}


$pdf = new PDF("P","cm","A4");
$pdf->SetMargins(3,1.5,2);
$pdf->AliasNbPages();
$pdf->AddPage();
$pdf->PrimeiraPagina('Renan Gonçalves Cattelan',5);
$pdf->AddPage();
$pdf->QuadroPeriodo('Renan Gonçalves Cattelan','2009/2',60);
$pdf->AddPage();
$pdf->RelatorioAtividade('Renan Gonçalves Cattelan','2009/2');
$pdf->SetFont('Times','',12);
$pdf->Output();
?>