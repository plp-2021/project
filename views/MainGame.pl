use Tk;
use strict;

my $main = MainWindow->new;
my $top;
my @matriz_ENEMY = (
        [1, 0, 0],
        [1, 0, 0],
        [2, 2, 2]);


my @matriz_MY = (
        [1, 0, 0],
        [1, 0, 0],
        [2, 2, 2]);

sub start{
    $main->minsize(qw(600 600));
    $main->title("Batalha naval");
    $main->configure(-background => "white");

    $top = $main->Frame(-background => "white");
    $top->pack(-side => 'top', -fill => 'x');
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
        my $left = $top->Frame(-background => "red");
        $left->pack(-side => 'left', -pady => 1, -padx => 1);

        for(my $j = 0; $j <= $#final ; $j++){ 
            
            $buttons[$i][$j] = $left->Button(-text => "0", -width => 3, -height => 3, -background => "white");
            
            if($param ne 'blocked'){
                $buttons[$i][$j]->configure(-command => [\&click, $j, $i, $buttons[$i][$j]]);
            }
            
            $buttons[$i][$j]->pack();  
        }
    }   

}

sub click {
    #receber parametros
    my @clicked=@_;
    
    #funcão que retorna valor da posicao da matriz (COMUNICACAO COM BACK)
    my $valor = 0;
    
    #atualizar matriz
    $clicked[2]->configure(-text=>"5");

    if($valor == 0){
                
    }
}


start();
plotMatrix(\@matriz_ENEMY, 'unblocked');
plotMatrix(\@matriz_MY, 'blocked');
MainLoop();