#!/usr/bin/perl
use Tk; 
use strict;
require "./back.pl";

# Criando janela principal
my $thisWindow = MainWindow->new;

my $container;
my $topBar;

#Fontes do jogo
my $font = $thisWindow->fontCreate(-size => 13, -weight => 'bold');
my $font2 = $thisWindow->fontCreate(-size => 17, -weight => 'bold');

my @btns_barcos;

#Guarda o navio selecionado
my $selectNavio;
my $selectOrientacao;

#Botão Navio
my @btn_navios;
my @btn_orientacao;

#Label Navio
my @label_navios = ('Porta Aviao', 'Guerra', 'Encouracado', 'Submarino');
my @label_orientacao = ('Vertical', 'Horizontal');

#Variaveis de controle do jogo
my $acc_water = 0;
my $acc_ship = 0;
my $qnt_ship = 0;
my $turn = 1;
my $acc_enemy = 0;

#Textos do jogos
my $turn_label; 
my $pont_label; 
my $acc_label;
my $qnt_ship_enemy = 0;

#Fontes do jogo
my $font = $thisWindow->fontCreate(-size => 13, -weight => 'bold');
my $font2 = $thisWindow->fontCreate(-size => 17, -weight => 'bold');

#Textos do jogos
my $turn_label; 
my $pont_label; 
my $acc_label;
my $qnt_ship_enemy = 0;

#Array de btns
my @btns_jogador;
my @btns_computador;
my @btns_barcos;

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
    my $new = $topBar->Button(-text => "Jogar", -command => [\&newGame], -background => 'white', -foreground =>'black', -width => 0, -height => 1.5, -font => $font)->pack(-side => 'left');
    my $exit = $topBar->Button(-text => "Sair", -command => [\&exitGame], -background => 'white', -foreground =>'black', -width => 3, -height => 1.5, -font => $font)->pack(-side => 'right');
}

sub topBarJogo{
    $topBar = $thisWindow->Frame(-relief => 'groove', -borderwidth => 3, -background => 'gray')->pack(-side => 'top', -fill =>'x');
    my $new = $topBar->Button(-text => "Criar jogo", -command => [\&createGame ], -background => 'white', -foreground =>'black', -width => 0, -height => 1.5, -font => $font)->pack(-side => 'left');
    my $exit = $topBar->Button(-text => "Sair", -command => [\&exitGame], -background => 'white', -foreground =>'black', -width => 3, -height => 1.5, -font => $font)->pack(-side => 'right');
}

sub exitGame {
    $thisWindow->destroy;
}

sub newGame {
    $thisWindow->packForget();
    startGame();
}

sub createGame { 
    $thisWindow->destroy;
    $thisWindow = MainWindow->new;
    start();
}

sub start {
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

sub selectNavio {
    $selectNavio = @_[0];
    for(my $i = 0; $i < 4; $i++){
        $btn_navios[$i]->configure(-background => "white");
    }
    $btn_navios[$selectNavio - 1]->configure(-background => "gray");
}

sub selectOrientacao {
    $selectOrientacao = @_[0];
        for(my $i = 0; $i < 2; $i++){
        $btn_orientacao[$i]->configure(-background => "white");
    }
    $btn_orientacao[$selectOrientacao]->configure(-background => "gray");
}

sub plotMatrixJogo  {
    #Receber Matriz e parametros
    my @final = @{$_[0]};
    my $param = $_[1];
    
    #plotando matriz
    for(my $i = 0; $i <= $#final; $i++){

        #Criar Frame
        my $left = $container->Frame(-background => "white");
        $left->pack(-side => 'left', -pady => 1, -padx => 1);
        for(my $j = 0; $j <= $#final ; $j++){             
            if($param ne 'blocked'){
                $btns_jogador[$i][$j] = $left->Button(-text => "0", -width => 3, -height => 3, -background => "white");
                $btns_jogador[$i][$j]->configure(-command => [\&clickJogar, $j, $i, $btns_jogador[$i][$j]]);
                $btns_jogador[$i][$j]->pack();  
                if($final[$i][$j] != 0){
                    $qnt_ship = $qnt_ship + 1;
                }
            }else{
                $btns_computador[$i][$j] = $left->Button(-text => "0", -width => 3, -height => 3, -background => "white");
                $btns_computador[$i][$j]->pack(); 
                if($final[$i][$j] != 0){
                    $qnt_ship_enemy = $qnt_ship_enemy + 1;
                }
                $btns_computador[$i][$j]->configure(-state => 'disabled');   
            }
        }   
    }   
}

sub enemyTurn {

    $turn = $turn + 1;
    $turn_label->configure(-text => "Turno $turn: turno do inimigo!", -foreground => 'red'); 

    #funcao que retorna a posicao (i, j) de onde o computador vai jogar(COMUNICACAO COM BACK)
    
    my $i   =   0; 
    my $j   =   0; 

    #funcão que retorna valor da posicao da matriz (i, j) (COMUNICACAO COM BACK) PRONTOOOOOOOOOOOo
    my $valor = jogadaENEMY($i, $j);
    

    if($valor == 0){
        #atualizar matriz inimiga
        $btns_computador[$i][$j]->configure(-text=>"9");
        #turno do jogador
        $turn = $turn + 1;
        $turn_label->configure(-text => "Turno $turn: Seu turno!", -foreground => 'green');  
        able();  
    }
    else{
        $acc_enemy = $acc_enemy + 1; 
        #atualizar matriz inimiga
        $btns_computador[$i][$j]->configure(-text=>"$valor");    
        if($acc_enemy == $qnt_ship_enemy){
            lost();
        }else{
           enemyTurn();   
        }
    }
}

sub won {
    my $response = $thisWindow->messageBox(-message => 'Voce Venceu!', -title => 'Vencedor', -type => 'AbortRetryIgnore', -default => 'Retry');
}

sub lost {
my $response = $thisWindow->messageBox(-icon => 'error', -message => 'Voce perdeu :(', -title => 'Perdedor', -type => 'AbortRetryIgnore', -default => 'Retry');
}

sub clickJogar {
    #receber parametros
    disable();
    my @clicked=@_;
    
    #funcão que retorna valor da posicao da matriz (COMUNICACAO COM BACK) PRONTOOOOOOO
    #Retorno {
    #  tipo de barco no ponto(i, j)
    #}
    my $valor = jogada($clicked[1], $clicked[0]);
    
    
    if($valor == 0){
        $acc_water = $acc_water + 1;
        #atualizar matriz
        $clicked[2]->configure(-text=>"9");
        $acc_label->configure(-text => "Acertos agua: $acc_water");
        enemyTurn();
    }
    else{
        $acc_ship = $acc_ship + 1; 
        #atualizar matriz
        $clicked[2]->configure(-text=>"$valor");
        $pont_label->configure(-text => "Sua pontuacao eh: $acc_ship/$qnt_ship");
        if($acc_ship == $qnt_ship){
            won();
        }else{
            $turn = $turn + 1;
            $turn_label->configure(-text => "Turno $turn: Seu turno!", -foreground => 'green');
            able();
        }
    }
}

sub startGame{
    #startar tela
    $thisWindow->destroy;
    $thisWindow = MainWindow->new;

    $thisWindow->minsize(qw(1100 700));
    $thisWindow->title("Batalha naval");
    $thisWindow->configure(-background => "white");

    #startar barra de menu
    topBarJogo();
    
    #start pontuacoes
    $container = $thisWindow->Frame(-background => "white");
    $container->pack(-side => 'top', -fill => 'x');

    my $points = $container->Frame(-background => "white");
    $points->pack(-side => 'top', -fill => 'x');
    
    my $left1       = $points->Frame(-background => 'white')->pack(-side => 'left', -padx => 0);
    $pont_label     = $left1->Label(-text => "Sua pontuacao eh: $acc_ship/$qnt_ship", -background => 'white', -width => 25, -height => 1.5, -font => $font, -anchor => 'w')->pack();
    $acc_label      = $left1->Label(-text => "Acertos agua: $acc_water", -background => 'white', -width => 25, -height => 1.5, -font => $font, -anchor => 'w')->pack();
    $turn_label     = $left1->Label(-text => "Turno $turn: Seu turno!", -background => 'white', -width => 25, -height => 1.5, -font => $font, -foreground => 'green', -anchor => 'w')->pack();
    
    #startar matrix
    my $name    = $container->Frame(-background => "white");
    $name->pack(-side => 'top', -fill => 'x');
    my $label_3 = $name->Label(-text => "Campo Inimigo", -background => 'white', -width => 12, -height => 1.5, -font => $font2)->pack(-side => 'left', -padx => 167);
    my $label_4 = $name->Label(-text => "Seu Campo", -background => 'white', -width => 12, -height => 1.5, -font => $font2)->pack(-side => 'right', -padx => 165);

    @matriz_ENEMY = adicionarBarcosMaquina();
    
    for(my $i = 0 ; $i< 10; $i++){
    for(my $j = 0; $j< 10; $j++){
        print "$matriz_ENEMY[$i][$j]";
    }
    print "\n";
    }

    plotMatrixJogo(\@matriz_ENEMY, 'unblocked');
    $pont_label->configure(-text => "Sua pontuacao eh: $acc_ship/$qnt_ship");
    my $midle   = $container->Frame(-background => "white")->pack(-side => 'left', -pady => 1, -padx => 20);

    

    plotMatrixJogo(\@matriz_MY, 'blocked');
    
    MainLoop();
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
            $btns_barcos[$i][$j] = $left->Button(-text => "0", -width => 3, -height => 3, -background => "white");
            $btns_barcos[$i][$j]->configure(-command => [\&click, $j, $i, $btns_barcos[$i][$j]]);
            $btns_barcos[$i][$j]->pack();  
        }   
    }   
}

sub click {
    my @clicked=@_;
    #funcao que retorna a minha matriz validada (COMUNICACAO COM BACK) PRONTOOOOOOOOOOOOOO
    #Retorno {
    #  [True e matriz] or [False e Mensagem]
    #}
    my $retorno;
    my @array; 

    ($retorno, @array) = &adicionarBarcos($selectNavio, $clicked[1], $clicked[0], $selectOrientacao, 0);

    if($retorno == 0){
        @matriz_MY = @array;
        for(my $i = 0; $i < 10; $i++){
            for(my $j = 0; $j < 10; $j++){
                $btns_barcos[$i][$j]->configure(-text=>"$array[$i][$j]");


                if($array[$i][$j] != 0){
                    $btns_barcos[$i][$j]->configure(-state => 'disabled');
                }
            }
        }
    }else{
        my $response = $thisWindow->messageBox(-icon => 'error', -message => 'Nao eh possivel adicionar navio', -title => 'Error', -type => 'AbortRetryIgnore', -default => 'Retry');
    } 
}

sub disable {
    for(my $i = 0; $i < 10; $i++){
        for(my $j = 0; $j < 10 ; $j++){             
            $btns_jogador[$i][$j]->configure(-state => 'disabled');  
        }   
    }
}

sub able {
    for(my $i = 0; $i < 10; $i++){
        for(my $j = 0; $j < 10 ; $j++){             
            $btns_jogador[$i][$j]->configure(-state => 'normal');  
        }   
    }
}

start();

