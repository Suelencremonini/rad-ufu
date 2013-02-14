<?php
#-- Incluindo o arquivo e instanciando o objeto
require_once 'fpdf.php';
#require('fpdf.php');


#-- Extendendo FPDF para implementar o header e o footer
class PDF extends FPDF {

	function Header() 
		{
			$this->Image('ufu.jpg',1,1,3);
			         // Criamos uma célula só com largura
		
          $this->Cell(15);
		
          // Definimos a fonte
		
          $this->SetFont('Arial','B',15);
		
          // Criamos outra célula com um "título"
		
          $this->Cell(4,1.5,'Digital Masters Studio',0,0,'C');	
		
          // "Pulamos Linha" para não sobrepor com o texto
		
          $this->Ln(3);
		}

	function Footer()
		{
// Definimos a fonte
		
          $this->SetFont('Arial','',10);
		
          // Posicionamos o texto a 9.5 cm da margem 
          // esquerda e a 4 cm da base
		
          $this->SetXY(9.5,-2.5);
			
          // Escrevemos afinal com link
		
          $this->Cell(4,1.5,'Digital Masters',0,0,'C','','http://www.digitalmasters.com.br');
		
          // Pulamos linha
		
          $this->Ln(0.5);
		
          // Posicionamos o segundo texto na mesma distância 
          // horizontal que o primeiro
		
          $this->SetX(9.5);
		
          // Copyright? o.O
		
          $this->Cell(4,1.5,'Copyright © - 2007',0,0,'C');
		}
}




$PDF = new FPDF('P', 'cm', 'A4');

#-- Incluindo as margens (SetMargins(float left, float top [, float right]))
$PDF -> SetMargins(3, 3, 2);

#-- Um documento deve ter um título e um autor 'interno'.
$PDF -> SetAuthor('PET Computação');
$PDF -> SetTitle('Documento gerado com FPDF');

#-- Adicionando uma página
$PDF -> AddPage();

#-- Atribuindo a fonte que será utilizada
$PDF -> SetFont('Times', 'B', 12);

#-- Coloca a posição inicial e final do texto
$PDF -> SetXY(3, 3);

#-- Escreve 'Hello Wolrd!' com tamanho de linha = 0.5 cm. Há um terceiro parâmetro, que é opcional e refere-se ao link (como se fosse uma âncora.
$PDF -> Write(0.5,'Hello World!');

#-- Barraene
$PDF -> Ln();

$PDF -> Write(0.5,'Loren impsun')

#-- Colocando imagen
#$PDF->Cell(0, 2, $PDF->Image('ufu.jpg', 1, 1,5));

#-- Colorindo linhas
#$PDF -> SetDrawColor(255,0,0);

#-- Criando linhas
#Line(float x1, float y1, float x2, float y2)
#$PDF -> Line(10,10,10,10)

$PDF->Output();
/*
-- Tabelas ----------------------------
"Tabelas"
Cell(float w [, float h [, string txt [, mixed border [, int ln [, string align [, int fill [, mixed link]]]]]]])
MultiCell(float w, float h, string txt [, mixed border [, string align [, int fill]]])
---------------------------------------

Cell()

w
Largura da célula. Estende-se até a margem direita do documento

h
Altura da célula. Valor padrão 0 (zero)

txt
Texto direto (entre '' [aspas únicas] como parâmetro) ou passado através de variável. Valor padrão vazio

border
Especifica se a célula deverá ter bordas
0 - Sem Borda / 1 - Com Borda

Ou, se no caso de apenas uma ou outra borda, informe uma ou mais das seguintes letras, em qualquer ordem.
L - Esquerda / T - Acima / R - Direita / B - Abaixo
Valor Padrão: 0 (zero)

ln
Indica onde será inserida uma quebra de linha.
0 - Direita / 1 - Início da próxima linha / 2 - Abaixo
Nota: Usar 1 equivale a usar 0 seguida de uma chamada à Ln().
Valor Padrão 0 (zero)

align
Alinha o texto dentro da célula, conforme a letra indicada:
L - Esquerda / C - Centralizado / R - Direita
Valor padrão vazio (equivalente ao uso de L)

fill
Indica se o fundo será preenchido ou não.
0 - Transparente / 1 - Preenchido

link
Assim como o terceiro parâmetro de Write() indica se o texto passado será ou não um link. Aceita também um ID (identificador) gerado por AddLink() [ver abaixo]

-- MultCell ------------------------------------------------------------------------------

MultiCell()

w
Largura da célula. Se zero for informado, a largura estende-se até a margem direita.
h
Altura da célula.
txt
Texto a ser impresso (exibido)
border
Especifica se a célula deverá ter bordas
0 - Sem Borda / 1 - Com Borda
Ou, se no caso de apenas uma ou outra borda, informe uma ou mais das seguintes letras, em qualquer ordem.
L - Esquerda / T - Acima / R - Direita / B - Abaixo
Valor Padrão: 0 (zero)
align
Alinha o texto dentro da célula, conforme a letra indicada:
L - Esquerda / C - Centralizado / R - Direita / J - Justificado
Valor padrão: J (Justificado)
fill
Indica se o fundo será preenchido ou não.
0 - Transparente / 1 - Preenchido
-----------------------------------------------------------------------------------------

*/


?>