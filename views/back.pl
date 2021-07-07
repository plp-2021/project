my @matriz_ENEMY = (
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);

my @matriz_MY = (
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        
my  @matrizAux; 
my $barco = 6;
my $barco_3 = 3;
my $barco_4 = 1;

#Quantidade de Barcos
my $portaAvioes = 1;
my $guerra = 1;
my $encouracados = 2;
my $submarino = 1;

sub retornarTamanhoBarco {

    my $tamanho = 0;
    my $barquinho = $_[0];

    if ($barquinho == 1 | $barquinho == 2) {
        $tamanho = $barco;
    }
    elsif($barquinho == 4) {
       $tamanho = $barco_4;
    }
    else {
       $tamanho = $barco_3;
    }

    return $tamanho;
}

sub disponivel {

    my  $posicaoI     = $_[0];
    my  $posicaoJ     = $_[1];
    my  $orientacao   = $_[2];
    my  $tamanhoBarco = $_[3];

    my $bool = 0;

    if($orientacao == 0) {
        for(my $i = 0; $i < $tamanhoBarco; $i++) {
            if($matrizAux[$posicaoI][$posicaoJ] != 0) {
                $bool = 1;
            } 
            $posicaoJ = $posicaoJ+1;
        }
    }
    else {
        for(my $i = 0; $i < $tamanhoBarco; $i++) {
            if($matrizAux[$posicaoI][$posicaoJ] != 0) {
                $bool = 1;
            } 
            $posicaoI = $posicaoI+1;  
        }
    }
    return $bool;
}

sub adicionarBarcos {

    my  $barco        = $_[0];
    my  $posicaoI     = $_[1];
    my  $posicaoJ     = $_[2];
    my  $orientacao   = $_[3];
    my  $maquina      = $_[4];

    my  $tamanhoBarco = retornarTamanhoBarco($barco);
    my $disp = disponivel($posicaoI, $posicaoJ, $orientacao, $tamanhoBarco);
    
    if($maquina == 1) {
        @matrizAux = @matriz_ENEMY;
    }
    else {
        @matrizAux = @matriz_MY;
    }
    if($disp == 0){
        if($barco == 4) {
            $matrizAux[$posicaoI][$posicaoJ] = $barco; 
        }
        else {
            my $auxJ = $posicaoJ;
            my $auxi = $posicaoI;
           
           for(my $i=0; $i < $tamanhoBarco; $i++) {
                if($orientacao == 0 & (($posicaoJ + $tamanhoBarco)-1) <= 9) {  
                    if($i == 0){
                        $matrizAux[$posicaoI][$posicaoJ] = $barco;
                    }
                    else {
                        $auxJ = $auxJ + 1;
                        $matrizAux[$posicaoI][$auxJ] = $barco;  
                    } 
                    $mensagem = 0;           
                } 
                elsif($orientacao == 1 & (($posicaoI + $tamanhoBarco)-1) <= 9) {
                    if($i == 0) {
                        $matrizAux[$posicaoI][$posicaoJ] = $barco;
                    }
                    else {
                        $auxi = $auxi + 1;
                        $matrizAux[$auxi][$posicaoJ] = $barco;
                       
                    }     
                    $mensagem = 0;  
                }
                else {
                    $mensagem = 1;
                    last;
                }
            }
        }
        
    }else{
        $mensagem = 1;
    }

    if($maquina == 1) {
        if($mensagem == 0) {
            @matriz_ENEMY = @matrizAux;
        }
       return ($mensagem, @matriz_ENEMY); 
    }

    elsif($maquina == 0) {
        if($mensagem == 0) {
            @matriz_MY = @matrizAux;
        }
        return ($mensagem, @matriz_MY);
    }     
}


sub verificarExisteBarco {
    my $flag = 0;
    my $tipoBarco = $_[0];

    if($tipoBarco == 1 & $portaAvioes != 0) {
        $flag = 1;
    }
    elsif($tipoBarco == 2 & $guerra != 0) {
        $flag = 1;
        
    }
    elsif($tipoBarco == 3  & $encouracados != 0) {
        $flag = 1;  
    }
    elsif($tipoBarco == 4  & $submarino != 0) {
       $flag = 1; 
    }
    return $flag;
}

sub removerQuantBarcos {
    my $tipoBarco = $_[0];

    if($tipoBarco == 1 & $portaAvioes != 0) {
        $portaAvioes = $portaAvioes - 1;
    }
    elsif($tipoBarco == 2 & $guerra != 0) {
        $guerra = $guerra - 1;
        
    }
    elsif($tipoBarco == 3  & $encouracados != 0) {
        $encouracados = $encouracados - 1;  
    }
    elsif($tipoBarco == 4  & $submarino != 0) {
        $submarino = $submarino - 1; 
    }

}

sub adicionarBarcosMaquina{ 

    my $posicao     = int rand(2);
    my $barc        = 1 + int rand(4);
    my $posicaoI    = int rand(10);
    my $posicaoJ    = int rand(10);
    my $existeBarco = verificarExisteBarco($barc);
    my $maquina     = 1;
    
    my $mensagem;
    my @matriz;
   
    if(($portaAvioes + $guerra + $encouracados + $submarino) == 0) {
        return @matriz_ENEMY; 
    }
    else{
        if($existeBarco == 0) {
            adicionarBarcosMaquina();
        }
        else {
            ($mensagem,@matriz) = adicionarBarcos($barc,$posicaoI,$posicaoJ,$posicao,$maquina);
            if($mensagem == 0) {
                removerQuantBarcos($barc);
                adicionarBarcosMaquina();
            }
            else {
                adicionarBarcosMaquina();
            }
        }
    }
}


sub jogada {
    my $i = $_[0];
    my $j = $_[1];

    return $matriz_ENEMY[$j][$i];
}


sub jogadaENEMY {
    my $i = $_[0];
    my $j = $_[1];

    return $matriz_MY[$i][$j];
}


sub jogadasComputador{

    my $posI  = int rand(10);
    my $posJ  = int rand(10);
    return ($posI,$posJ); 
}





