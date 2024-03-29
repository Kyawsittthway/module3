import 'package:hive/hive.dart';

import '../../data.vos/vos/actor_vo.dart';
import '../daos/actor_dao.dart';
import '../daos/hive_constants.dart';

class ActorDaoImpl extends ActorDao{
  static final ActorDaoImpl _singleton = ActorDaoImpl._internal();

  factory ActorDaoImpl(){
    return _singleton;
  }

  ActorDaoImpl._internal();

  void saveAllActors(List<ActorVO>actorList) async{
    Map<int,ActorVO> actorMap = Map.fromIterable(actorList,key: (actor)=>actor.id,value:(actor)=>actor);
    await getActorBox().putAll(actorMap);
  }

  List<ActorVO> getAllActors(){
    return getActorBox().values.toList();
  }

  Box<ActorVO>getActorBox(){
    return Hive.box<ActorVO>(BOX_NAME_ACTOR_VO);
  }
}