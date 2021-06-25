use Tk;
use strict;


#variaveis globais
my $main = MainWindow->new;
my $top;
my $acc_water = 0;
my $acc_ship = 0;
my $qnt_ship = 0;

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

sub start{
    $main->minsize(qw(1100 900));
    $main->title("Batalha naval");
    $main->configure(-background => "white");

    $top = $main->Frame(-background => "white");
    $top->pack(-side => 'top', -fill => 'x');

    plotMatrix(\@matriz_ENEMY, 'unblocked');
    plotMatrix(\@matriz_MY, 'blocked');
    
    MainLoop();
}

sub plotMatrix  {
    #Receber Matriz e parametros
    my @final = @{$_[0]};
    my $param = $_[1];
    
    #buttons
    my @buttons;
    
    #plotando matriz
    for(my $i = 0; $i <= $#final; $i++){

        #Criar Frame
        my $left = $top->Frame(-background => "white");
        $left->pack(-side => 'left', -pady => 1, -padx => 1);

        for(my $j = 0; $j <= $#final ; $j++){ 
            
            $buttons[$i][$j] = $left->Button(-text => "0", -width => 3, -height => 3, -background => "white");
            
            if($param ne 'blocked'){
                $buttons[$i][$j]->configure(-command => [\&click, $j, $i, $buttons[$i][$j]]);

                if($final[$i][$j] != 0){
                    $qnt_ship = $qnt_ship + 1;
                }
            }
            
            $buttons[$i][$j]->pack();  
        }   
    }   
}

sub ganhou {

}

sub click {
    #receber parametros
    my @clicked=@_;
    
    #funcão que retorna valor da posicao da matriz (COMUNICACAO COM BACK)
    my $valor = 0;
    
    #atualizar matriz
    $clicked[2]->configure(-text=>"$valor");

    if($valor == 0){
        $acc_water = $acc_water + 1;
    }
    else{
        $acc_ship = $acc_ship + 1; 
        
        if($acc_ship == $qnt_ship){
            ganhou();
        }else{

        }
    }

}

start();