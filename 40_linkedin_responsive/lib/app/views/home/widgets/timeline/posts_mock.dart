/*
  Sabrina Karen
*/

import 'package:linkedin_responsive/app/models/post_model.dart';
import 'package:linkedin_responsive/app/models/profile_identification_model.dart';

class PostsMock {

  List<PostModel> getPostsMock() {

    return [

      PostModel(
        profileIdentificationObject: ProfileIdentificationModel(
          profileImgPath: 'assets/profile_01.jpg',
          name: 'Daiane Luzia',
          postMoment: '19 min',
          occupation: 'Assistente de recursos humanos | Tech Logística',
        ),
        postText: "Olá!\n\nCompartilho com todos o meu certificado de conclusão do curso online de Desenvolvimento Android e IOS com Flutter 2020 - Crie 15 Apps. Realizei este curso através da plataforma Udemy, e tem uma duração total de 61,5 horas. Iniciei o curso no dia 24/04/2020 e finalizei hoje, dia 01/07/2020. Este certificado representa um grande aprendizado que alcancei com as aulas e, principalmente, com as mãos na massa. Flutter é uma tecnologia incrível que permite o desenvolvimento mobile de aplicativos que podem ser compilados nativamente tanto para Android, quanto para iOS. Durante este curso, desenvolvi 33 aplicativos relativamente simples, e que estão disponíveis em meu GitHub através do link: https://lnkd.in/gaaRBFX.",
        postImg: 'assets/post_img_01.jpg',
      ),

      PostModel(
        profileIdentificationObject: ProfileIdentificationModel(
          profileImgPath: 'assets/profile_02.jpg',
          name: 'Francisco Lorenzo',
          postMoment: '37 min',
          occupation: 'Frontend delevoper na Eng Inside',
        ),
        postText: "Este é um texto aleatório, apenas para preencher espaço nest post de exemplo, que por sua vez fica dentro de um projeto de exemplo.",
        postImg: 'assets/post_img_02.jpg',
      ),

      PostModel(
        profileIdentificationObject: ProfileIdentificationModel(
          profileImgPath: 'assets/profile_03.jpg',
          name: 'Giovana Andreia',
          postMoment: '1 dia',
          occupation: 'Designer de interiores na Craft Arquitetura',
        ),
        postText: "Lorem ipsum hac ullamcorper curabitur egestas nisi nibh mattis, vehicula taciti porta purus neque commodo tempus cursus, aenean netus donec posuere dui pretium leo. conubia quam nostra felis nunc venenatis et congue at faucibus, pharetra semper donec felis at cubilia tempus mattis pulvinar odio, metus posuere taciti erat placerat vulputate dictumst diam. dictum aliquet condimentum cubilia est lectus tincidunt nostra netus sodales, eu blandit nam nostra porttitor diam per venenatis tincidunt senectus, vulputate quisque ultrices pellentesque maecenas tortor risus ullamcorper. auctor neque mauris molestie blandit augue pulvinar tincidunt, adipiscing lacus mollis suspendisse viverra litora, etiam purus sapien torquent libero eros.",
        postImg: 'assets/post_img_03.jpg',
      ),

      PostModel(
        profileIdentificationObject: ProfileIdentificationModel(
          profileImgPath: 'assets/profile_04.jpg',
          name: 'Noah Elias',
          postMoment: '2 dias',
          occupation: 'Gestor da qualidade | Mec Criação',
        ),
        postText: "Non quam litora elit rutrum rhoncus suscipit dictum tincidunt fringilla, ultricies auctor blandit lacinia feugiat gravida sed vivamus maecenas nostra, neque faucibus erat molestie turpis sed pretium per.",
        postImg: 'assets/post_img_04.jpg',
      ),

      PostModel(
        profileIdentificationObject: ProfileIdentificationModel(
          profileImgPath: 'assets/profile_05.jpg',
          name: 'Analu Sarah',
          postMoment: '1 sem',
          occupation: 'Gerente de marketing | RedRiver Marketing',
        ),
        postText: "-- Apenas 'aprender' não é suficiente, é necessário também saber e querer aperfeiçoar!\n\n\nOlá!\n\nCompartilho com todos o meu certificado de conclusão do curso online de Responsividade no Flutter | Mobile, Tablet, Web e Desktop.\nRealizei este curso através da plataforma Udemy, e tem uma duração total de 6 horas (pode até parecer pouco, mas foi tempo suficiente para absorção de conteúdos de qualidade).\nEste certificado representa um enorme aperfeiçoamento que alcancei para o desenvolvimento de apps cross-platform, fazendo uso do Flutter.\nApenas desenvolver aplicativos para Android e iOS não estava sendo suficiente, então agora aprendi técnicas e recursos para deixar meus apps ainda mais responsivos e perfeitamente funcionais até mesmo para web.\nEspero desenvolver um aplicativo bem legal para compartilhar com todos um pouco deste aperfeiçoamento.",
        postImg: 'assets/post_img_05.jpg',
      ),

    ];

  }

}