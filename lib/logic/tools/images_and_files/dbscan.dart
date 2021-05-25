// Copyright (c) 2017, erikrahtjen. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

class DBSCAN<T> {
  /// A DBSCAN object creates clusters of nearby data as defined by a distance function
  ///
  /// DBSCAN takes 4 inputs: a List<T> _dataset,
  /// An _epsilon which is a scalar representing the size of a cluster
  /// A _minPts int which represents the minimum number of things to qualify as a cluster
  /// A _distance function which takes two items of type T and returns a scalar distance between the two.
  DBSCAN(this._dataset, this._epsilon, this._minPts, num this._distance(T a, T b)) {
    _visited = []..length = _dataset.length;
    _assigned = []..length = _dataset.length;

    for (int pointId = 0; pointId < _dataset.length; pointId++) {
      // if point is not visited, check if it forms a cluster
      if (!_hasPointBeenVisited(pointId)) {
        this._visited[pointId] = 1;

        // if closest neighborhood is too small to form a cluster, mark as noise
        var neighbors = _regionQuery(pointId);

        if (neighbors.length < _minPts) {
          _noise.add(pointId);
        } else {
          // create new cluster and add point
          var clusterId = _clusters.length;
          _clusters.add(new List());
          _addToCluster(pointId, clusterId);

          _expandCluster(clusterId, neighbors);
        }
      }
    }
  }

  final List<T> _dataset;
  final num _epsilon;
  final num _minPts;
  final Function _distance;

  List<List<int>> _clusters = [];
  List<int> _noise = [];
  List<int> _visited = [];
  List<int> _assigned = [];

  /// Returns a [List]<T>, where each list represents a cluster of "nearby" data
  List<List<T>> get clusters {
    List<List<T>> returnedClustersOfData = new List();

    for (var cluster in _clusters) {
      List<T> dataCluster = [];
      cluster.forEach((int datumId) {
        dataCluster.add(_dataset[datumId]);
      });
      returnedClustersOfData.add(dataCluster);
    }

    return returnedClustersOfData;
  }

  /// Returns a [List]<T> of all the unclustered points, referred to as noise.
  List<T> get noise {
    List<T> returnedNoise = new List();

    for (var datumId in _noise) {
      returnedNoise.add(_dataset[datumId]);
    }

    return returnedNoise;
  }

  List<int> _regionQuery(int pointId) {
    var neighbors = <int>[];

    for (var id = 0; id < _dataset.length; id++) {
      var dist = _distance(_dataset[pointId], _dataset[id]);
      if (dist < _epsilon) {
        neighbors.add(id);
      }
    }

    return neighbors;
  }

  void _addToCluster(int pointId, int clusterId) {
    _clusters[clusterId].add(pointId);
    _assigned[pointId] = 1;
  }

  void _expandCluster(int clusterId, neighbors) {
    /**
     * It's very important to calculate length of neighbors array each time,
     * as the number of elements changes over time
     */
    for (var i = 0; i < neighbors.length; i++) {
      var pointId2 = neighbors[i];

      if (_visited[pointId2] != 1) {
        _visited[pointId2] = 1;
        var neighbors2 = this._regionQuery(pointId2);

        if (neighbors2.length >= _minPts) {
          neighbors = _mergeArrays(neighbors, neighbors2);
        }
      }

      // add to cluster
      if (_assigned[pointId2] != 1) {
        _addToCluster(pointId2, clusterId);
      }
    }
  }

  List<int> _mergeArrays(List<int> a, List<int> b) {
    var len = b.length;

    for (var i = 0; i < len; i++) {
      var P = b[i];
      if (a.indexOf(P) < 0) {
        a.add(P);
      }
    }

    return a;
  }

  bool _hasPointBeenVisited(int pointId) {
    return _visited[pointId] == 1;
  }
}