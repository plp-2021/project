use Tk; 
use strict;
# Criando janela principal
my $thisWindow = MainWindow->new;

my $container;
my $topBar;

#Fontes do jogo
my $font = $thisWindow->fontCreate(-size => 13, -weight => 'bold');
my $font2 = $thisWindow->fontCreate(-size => 17, -weight => 'bold');

#Aux
my @portaAvies = [1,1,1,1,1,1];
my @navioGuerra = [2,2,2,2,2,2,2];
my @navioEncoracao = [3,3,3];
my @submarino = [1];
my @btn_enemy;

my $selectNavio;
my $selectOrientacao;

my @btn_navios;
my @btn_orientacao;

my @label_navios = ('Porta Aviao', 'Guerra', 'Encouracado', 'Submarino');
my @label_orientacao = ('Horizontal', 'Vertical');

#Variaveis de controle do jogo
my $acc_water = 0;
my $acc_ship = 0;
my $qnt_ship = 0;
my $turn = 1;
my $acc_enemy = 0;

#Fontes do jogo
my $font = $thisWindow->fontCreate(-size => 13, -weight => 'bold');
my $font2 = $thisWindow->fontCreate(-size => 17, -weight => 'bold');

#Textos do jogos
my $turn_label; 
my $pont_label; 
my $acc_label;
my $qnt_ship_enemy = 0;

my @btn_enemy;

my @btn_my;

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

sub topBar{
    $topBar = $thisWindow->Frame(-relief => 'groove', -borderwidth => 3, -background => 'gray')->pack(-side => 'top', -fill =>'x');
    my $new = $topBar->Button(-text => "Iniciar", -command => [\&newGame], -background => 'white', -foreground =>'black', -width => 0, -height => 1.5, -font => $font)->pack(-side => 'left');
    my $exit = $topBar->Button(-text => "Sair", -command => [\&exitGame], -background => 'white', -foreground =>'black', -width => 3, -height => 1.5, -font => $font)->pack(-side => 'right');
}

sub exitGame{
    $thisWindow->destroy;
}

sub newGame{
    $thisWindow->packForget();
    startGame();
}

sub start{
    #startar tela
    $thisWindow->minsize(qw(1100 700));
    $thisWindow->title("Batalha naval");
    $thisWindow->configure(-background => "white");

    #startar barra de menu
    topBar();
    
    #startar matrix
    $container = $thisWindow->Frame(-background => "white");
    $container->pack(-side => 'top', -fill => 'x');
    
    plotMatrix(@matriz_MY);

    my $subcontainer = $container->Frame(-background => "white");
    $subcontainer->pack(-side => 'top', -fill => 'x');

    my $label1 = $subcontainer->Label(-text => "Selecione o tipo de navio:", -background => 'white', -width => 25, -height => 1.5, -font => $font)->pack();
    
    my $midle   = $subcontainer->Frame(-background => "white")->pack(-side => 'left', -pady => 1, -padx => 125);
    for(my $i = 0; $i < 4; $i++){
        my $aux = @label_navios[$i];
        $btn_navios[$i] = $midle->Button(-text => "$aux", -width => 10, -height => 3, -background => "white");
        $btn_navios[$i]->configure(-command => [\&selectNavio,  $i+1]);
        $btn_navios[$i]->pack(-side => 'left', -padx => 10);
    }
 
    my $subcontainer1 = $container->Frame(-background => "white");
    $subcontainer1->pack(-side => 'top', -fill => 'x');

    my $label1 = $subcontainer1->Label(-text => "Selecione a orientacao:", -background => 'white', -width => 25, -height => 1.5, -font => $font)->pack();
    

    my $midle1   = $subcontainer1->Frame(-background => "white")->pack(-side => 'left', -pady => 1, -padx => 240);
    
    for(my $i = 0; $i < 2; $i++){
        my $aux = @label_orientacao[$i];
        $btn_orientacao[$i] = $midle1->Button(-text => "$aux", -width => 10, -height => 3, -background => "white");
        $btn_orientacao[$i]->configure(-command => [\&selectOrientacao,  $i]);
        $btn_orientacao[$i]->pack(-side => 'left', -pady => 11, -padx => 10);
    }
    
    MainLoop();
}

sub selectNavio{
    $selectNavio = @_[0];
}

sub selectOrientacao{
    $selectOrientacao = @_[0];
}

sub plotMatrix  {
    #Receber Matriz e parametros
    my @final = @_;
    
    #plotando matriz
    for(my $i = 0; $i <= $#final; $i++){

        #Criar Frame
        my $left = $container->Frame(-background => "white");
        $left->pack(-side => 'left', -pady => 1, -padx => 1);
        for(my $j = 0; $j <= $#final ; $j++){             
            $btn_enemy[$i][$j] = $left->Button(-text => "0", -width => 3, -height => 3, -background => "white");
            $btn_enemy[$i][$j]->configure(-command => [\&click, $j, $i, $btn_enemy[$i][$j]]);
            $btn_enemy[$i][$j]->pack();  
        }   
    }   
}

sub click{
    my @clicked=@_;
    #funcao que retorna a minha matriz validada (COMUNICACAO COM BACK)
    #Retorno {
    #  [True e matriz] or [False e Mensagem]
    #}
    #print("$selectOrientacao, $selectNavio, $clicked[0], $clicked[1]");
    my $retorno;
    my @array; 

    ($retorno, @array) = &foo();

    if($retorno){
        for(my $i = 0; $i < 10; $i++){
            for(my $j = 0; $j < 10; $j++){
                $btn_enemy[$i][$j]->configure(-text=>"$array[$i][$j]");
            }
        }
    }else{
        my $response = $thisWindow->messageBox(-icon => 'error', -message => 'Nao eh possivel adicionar navio', -title => 'Error', -type => 'AbortRetryIgnore', -default => 'Retry');
    } 
}
sub foo {
  return (0,(
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]));
}

start();