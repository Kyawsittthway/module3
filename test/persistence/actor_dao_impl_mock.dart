import 'package:module3/data.vos/vos/actor_vo.dart';
import 'package:module3/persistence/daos/actor_dao.dart';

class ActorDaoImplMock extends ActorDao{

  Map<int,ActorVO> actorListFromDatabaseMock = {};
  @override
  List<ActorVO> getAllActors() {
    return actorListFromDatabaseMock.values.toList();
  }

  @override
  void saveAllActors(List<ActorVO> actorList) {
    actorList.forEach((actor) {
      actorListFromDatabaseMock[actor.id] = actor;
    });
  }

}