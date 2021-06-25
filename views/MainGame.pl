use Tk;
use strict;

#variaveis globais
my $main = MainWindow->new;
my $top;
my $menuBar;
my $acc_water = 0;
my $acc_ship = 0;
my $qnt_ship = 0;
my $turn = 1;
my $acc_enemy = 0;
my $font = $main->fontCreate(-size => 13, -weight => 'bold');
my $font2 = $main->fontCreate(-size => 17, -weight => 'bold');
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


sub menuBar{
    $menuBar = $main->Frame(-relief => 'groove', -borderwidth => 3, -background => 'gray')->pack(-side => 'top', -fill =>'x');
    my $new = $menuBar->Menubutton(-text => "Novo Jogo", -background => 'white', -foreground =>'black', -width => 0, -height => 1.5, -font => $font)->pack(-side => 'left');
    my $exit = $menuBar->Menubutton(-text => "Sair", -background => 'white', -foreground =>'black', -width => 3, -height => 1.5, -font => $font)->pack(-side => 'right');
}

sub start{
    #startar tela
    $main->minsize(qw(1100 700));
    $main->title("Batalha naval");
    $main->configure(-background => "white");

    #startar barra de menu
    menuBar();

    #start pontuacoes
    $top = $main->Frame(-background => "white");
    $top->pack(-side => 'top', -fill => 'x');

    my $points = $top->Frame(-background => "white");
    $points->pack(-side => 'top', -fill => 'x');
    
    my $left1       = $points->Frame(-background => 'white')->pack(-side => 'left', -padx => 0);
    $pont_label     = $left1->Label(-text => "Sua pontuacao eh: $acc_ship/$qnt_ship", -background => 'white', -width => 25, -height => 1.5, -font => $font, -anchor => 'w')->pack();
    $acc_label      = $left1->Label(-text => "Acertos agua: $acc_water | navios: $acc_ship", -background => 'white', -width => 25, -height => 1.5, -font => $font, -anchor => 'w')->pack();
    $turn_label     = $left1->Label(-text => "Turno $turn: Seu turno!", -background => 'white', -width => 25, -height => 1.5, -font => $font, -foreground => 'green', -anchor => 'w')->pack();
    
    #startar matrix
    my $name    = $top->Frame(-background => "white");
    $name->pack(-side => 'top', -fill => 'x');
    my $label_3 = $name->Label(-text => "Campo Inimigo", -background => 'white', -width => 12, -height => 1.5, -font => $font2)->pack(-side => 'left', -padx => 167);
    my $label_4 = $name->Label(-text => "Seu Campo", -background => 'white', -width => 12, -height => 1.5, -font => $font2)->pack(-side => 'right', -padx => 165);

    plotMatrix(\@matriz_ENEMY, 'unblocked');
    my $midle   = $top->Frame(-background => "white")->pack(-side => 'left', -pady => 1, -padx => 20);
    plotMatrix(\@matriz_MY, 'blocked');
    
    MainLoop();
}

sub exitGame {

}

sub enemyTurn {
    #funcao que retorna a jogada do inimigo (COMUNICACAO COM BACK)
    my $i   =   0;
    my $j   =   0;

    #funcão que retorna valor da posicao da matriz (COMUNICACAO COM BACK)
    my $valor = 0;
    

    if($valor == 0){
        #atualizar matriz inimiga
        $btn_my[$i][$j]->configure(-text=>"9");
        #turno do jogador
    }
    else{
        $acc_enemy = $acc_enemy + 1; 
        #atualizar matriz inimiga
        $btn_my[$i][$j]->configure(-text=>"$valor");    
        if($acc_enemy == $qnt_ship_enemy){
            lost();
        }else{
            #turno do jogador    
        }
    }

}

sub plotMatrix  {
    #Receber Matriz e parametros
    my @final = @{$_[0]};
    my $param = $_[1];
    
    #plotando matriz
    for(my $i = 0; $i <= $#final; $i++){

        #Criar Frame
        my $left = $top->Frame(-background => "white");
        $left->pack(-side => 'left', -pady => 1, -padx => 1);
        for(my $j = 0; $j <= $#final ; $j++){             
            if($param ne 'blocked'){
                $btn_enemy[$i][$j] = $left->Button(-text => "0", -width => 3, -height => 3, -background => "white");
                $btn_enemy[$i][$j]->configure(-command => [\&click, $j, $i, $btn_enemy[$i][$j]]);
                $btn_enemy[$i][$j]->pack();  
                if($final[$i][$j] != 0){
                    $qnt_ship = $qnt_ship + 1;
                }
            }else{
                $btn_my[$i][$j] = $left->Button(-text => "0", -width => 3, -height => 3, -background => "white");
                $btn_my[$i][$j]->configure(-command => [\&click, $j, $i, $btn_my[$i][$j]]);
                $btn_my[$i][$j]->pack(); 
                if($final[$i][$j] != 0){
                    $qnt_ship_enemy = $qnt_ship_enemy + 1;
                } 
            }
        }   
    }   
}

sub won {

}

sub lost{

}

sub click {
    #receber parametros
    my @clicked=@_;
    
    #funcão que retorna valor da posicao da matriz (COMUNICACAO COM BACK)
    my $valor = 0;
    
    
    if($valor == 0){
        $acc_water = $acc_water + 1;
        #atualizar matriz
        $clicked[2]->configure(-text=>"9");
    }
    else{
        $acc_ship = $acc_ship + 1; 
        #atualizar matriz
        $clicked[2]->configure(-text=>"$valor");
        
        if($acc_ship == $qnt_ship){
            won();
        }else{
            enemyTurn();
        }
    }
}

start();