
import 'dart:math';

final int _popSize = 100;
final int _geneSize = 10;


void main(List<String> arguments) {
  List<List<int>> pop = [];

  for(int i = 0; i < _popSize; i++){
    List<int> indiv = List<int>.filled(_geneSize, 0);
    for(int n = 0; i < _geneSize; n++){
      indiv[n] = Random().nextInt(2) == 0 ? Random().nextInt(10) : -Random().nextInt(10); /// chooses a value for each gene between -9 and 9
    }
    pop[i] = indiv;
  }

  microbialTournament(pop, 5, 0.5, 0.25); //. run one interation of the tournament
}

/// runs one iteration of the tournament
void microbialTournament(List<List<int>> population, int demeSize, double recomRate, double mutationRate){
  final int indivAIndex = Random().nextInt(population.length); //choose A randomly
  final List<int> indivA = population[indivAIndex];
  final List<int> indivB = population[(indivAIndex + 1 + Random().nextInt(demeSize)) % population.length]; //choose B from the deme, and account for wrap-around
  List<int> winningIndiv, losingIndiv;
  if(eval(indivA) > eval(indivB)){ /// set the winning and losing indivs based on the eval function
    winningIndiv = indivA;
    losingIndiv = indivB;
  } else { 
    winningIndiv = indivB;
    losingIndiv = indivA;
  }


  for(int gene in winningIndiv) {
    if(Random().nextDouble() < recomRate){ /// transfer genes based on the recom rate
      losingIndiv[gene] = winningIndiv[gene]; 
    }
    if (Random().nextDouble() < mutationRate){ /// mutate based on the mutation rate
      losingIndiv[gene] = -losingIndiv[gene];  ///Not restricted to 1's and 0's, but the negative/positive values serve the same purpose.
    }
  }
}

/// incentives indivs with positively-valued genes
int eval(List<int> indiv) {
  int total = 0;
  for(int gene in indiv) {
    total += gene; /// add up all gene values.
  }

  return total;
}