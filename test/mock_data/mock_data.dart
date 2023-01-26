import 'package:module3/data.vos/vos/actor_vo.dart';
import 'package:module3/data.vos/vos/credit_vo.dart';
import 'package:module3/data.vos/vos/genre_vo.dart';
import 'package:module3/data.vos/vos/movie_vo.dart';

List<MovieVO> getMockMoviesForTest() {
  return [
    MovieVO(
        false,
        "/ugS5FVfCI3RV0ZwZtBV3HAV75OX.jpg",
        [16, 878, 28],
        null,
        null,
        null,
        "",
        610150,
        null,
        "ja",
        "ドラゴンボール超 スーパーヒーロー",
        "The Red Ribbon Army, an evil organization that was once destroyed by Goku in the past, has been reformed by a group of people who have created new and mightier Androids, Gamma 1 and Gamma 2, and seek vengeance against Goku and his family.",
        749.799,
        "/rugyJdeoJm7cSJL1q4jBpTNbxyU.jpg",
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        "2022-06-11",
        "Dragon Ball Super: Super Hero",
        false,
        8.0,
        2009,
        false,
        false,
        true),
    MovieVO(
        false,
        "/7ABsaBkO1jA2psC8Hy4IDhkID4h.jpg",
        [16, 878, 28],
        null,
        null,
        null,
        "",
        19995,
        null,
        "en",
        "Avatar",
        "In the 22nd century, a paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization.",
        639.348,
        "/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg",
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        "2009-12-15",
        "Avatar",
        false,
        7.528,
        26503,
        false,
        true,
        false),
    MovieVO(
        false,
        "/mqsPyyeDCBAghXyjbw4TfEYwljw.jpg",
        [10752, 18, 28],
        null,
        null,
        null,
        "",
        49046,
        null,
        "de",
        "Im Westen nichts Neues スーパーヒーロー",
        "Paul Baumer and his friends Albert and Muller, egged on by romantic dreams of heroism, voluntarily enlist in the German army. Full of excitement and patriotic fervour, the boys enthusiastically march into a war they believe in. But once on the Western Front, they discover the soul-destroying horror of World War I.",
        2467.37,
        "/hYqOjJ7Gh1fbqXrxlIao1g8ZehF.jpg",
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        "2022-10-07",
        "All Quiet on the Western Front",
        false,
        7.9,
        637,
        true,
        false,
        false)
  ];
}

List<ActorVO> getMockActors() {
  return [
    ActorVO(false, 500, [], 31.299, "Tom Cruise",
        "/8qBylBsQf4llkGrWR3qAsOtOU8O.jpg"),
    ActorVO(false, 6161, [], 80.669, "Jennifer Connelly",
        "/egh1eOHuYgeoqdlLQgaXMl6cPOm.jpg"),
    ActorVO(false, 18918, [], 39.686, "Dwayne Johnson",
        "/kuqFzlYMc2IrsOyPznMd1FroeGq.jpg"),
  ];
}

List<GenreVO> getMockGenres(){
  return [
    GenreVO(id: 1, name: "Action"),
    GenreVO(id: 2, name: "Adventure"),
    GenreVO(id: 3, name: "Comedy")
  ];
}

List<CreditVO> getMockCredit(){
  return [
    CreditVO(false, 2, 55934, "Directing", "Taika Waititi", 29.867, 89, "Old Kronan God (voice)", "62c8c2ae595a5600da429229", 4, "Taika Waititi", "/aH6MgwFhomAPNBRPyO2fhpU5kbk.jpg"),
    CreditVO(false, 2, 55934, "Production", "Simona Paparelli", 0.629, 147, "Bao, God of Dumplings (voice)", "62c8ce06595a5600db7ddf96", 71, "Simona Paparelli", "null"),
    CreditVO(false, 2, 3203691, "Writing", "Suren Jayemanne,",0.631, 101, "Asgardian Stagehand", "62c8c80e90b87e055d7bd10a", 24, "Suren Jayemanne", "null"),
  ];
}