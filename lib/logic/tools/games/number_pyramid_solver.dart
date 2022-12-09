import 'package:gc_wizard/logic/tools/games/dennistreysa_number_pyramid_solver/pyramid.dart';

List<List<List<int>>> solvePyramid(List<List<int>> pyramid, int maxSolutions) {
	return solve(pyramid, maxSolutions: maxSolutions);
}