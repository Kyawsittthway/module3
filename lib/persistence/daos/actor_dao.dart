import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:module3/persistence/daos/hive_constants.dart';

import '../../data.vos/vos/actor_vo.dart';

abstract class ActorDao{
  void saveAllActors(List<ActorVO>actorList);
  List<ActorVO> getAllActors();
}