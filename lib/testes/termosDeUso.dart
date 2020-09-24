//import 'package:flutter/material.dart';
//import 'package:ett_app/domains/solicitacao.dart';
//import 'package:ett_app/domains/usuario.dart';
//import 'package:ett_app/screens/appBar.dart';
//
//import 'login.dart';
//
//class TermosDeUso extends StatelessWidget {
//  Usuario user;
//  Token token;
//  Solicitacao sol;
//
//  TermosDeUso(
//      {Key key,
//        this.user, this.token, this.sol})
//      : super(key: key);
//
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: appBar (user: user, token: token, sol: sol),
//      backgroundColor: Colors.white,
//      body: SafeArea(
//          child: ListView(
//        children: <Widget>[
//          Flexible(
//            flex: 2,
//            child: Container(
//              width: double.infinity,
//              child: Padding(
//                padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
//                child: Center(
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Image(
//                        image: AssetImage('images/logo-slim.png'),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(left: 30.0, top: 10.0),
//            child: Row(
//              children: <Widget>[
//                Text("Termos de uso",
//                    textAlign: TextAlign.start,
//                    style: TextStyle(
//                        fontSize: 22.0,
//                        color: Colors.green,
//                        fontFamily: "Poppins-Bold",
//                        letterSpacing: .6)),
//              ],
//            ),
//          ),
//          SizedBox(
//            height: 30.0,
//          ),
//          Flexible(
//            flex: 3,
//            child: Padding(
//              padding: const EdgeInsets.all(30.0),
//              child: Text(
//                'O usuário, ao criar o seu cadastro, concorda com os sequintes termos de uso e política de privacidade abaixo explicitados:\n\n'
//                'A prioridade da AETUR é assegurar a privacidade e a segurança das informações cedidas pelos usuários cadastrados (“Usuário”), bem como firmar o compromisso com a transparência no tratamento das informações. Neste sentido, a AETUR envidará seus melhores esforços para garantir a proteção dos dados cadastrais, seus documentos e a privacidade de nossos Usuários.\n\n'
//
//
//                 'A AETUR de maneira específica, recolhe e usa algumas informações de identificação pessoal necessárias para atingir os fins descritos na presente Política de Privacidade. Ao utilizar a AETUR, o Usuário reconhece e aceita este recolhimento, conforme descrito neste Instrumento.\n\n'
//
//
//                    'Essas informações podem se referir àquelas necessárias para identificação do usuário, para fins de cadastro e cumprimento da legislação, tais como seu nome, CPF e foto, ou ainda àquelas necessárias para prover os serviços da AETUR de forma eficiente e segura.\n\n'
//
//
//                    ' A AETUR se reserva o direito de modificar esta Política de Privacidade a qualquer momento. Todas as modificações serão avisadas através dos nossos veículos oficiais de comunicação com o Usuário que, ao permanecer no sistema, demonstra que concorda com as modificações realizadas.\n\n'
//
//                    ' 1 – Cadastro\n\n'
//
//
//                    'O objetivo da AETUR em permitir que o Usuário voluntariamente coloque suas informações e facilitar a navegação e o uso de suas ferramentas.\n\n'
//
//
//                    'Para se tornar um Usuário, o primeiro passo é o seu cadastro pessoal, onde nome, login, e-mail, número de CPF e senha são dados obrigatórios.\n\n'
//
//
//                'O Usuário tem direito a acessar, modificar, corrigir os seus dados ou até mesmo eliminá-los. No entanto, por questões de segurança, se o Usuário atualizar qualquer informação de seu cadastro, a AETUR poderá manter uma cópia das informações anteriores fornecidas por ele em nossos arquivos e documentações sobre uso do sistema.\n\n'
//
//
//                'Para mudanças mais importantes, a AETUR faz uso de criptografia de senha e protocolos de confirmação via e-mail.\n\n'
//
//
//                '2 – Informações pessoais coletadas pela AETUR\n\n'
//
//
//                    'A AETUR utiliza-se do aplicativo de “cookies” (dados no computador do Usuário) para permitir sua correta identificação, além de melhorar a qualidade das informações oferecidas em seu portal para os Usuários.\n\n'
//
//
//                'Além das informações pessoais fornecidas, a AETUR tem a capacidade tecnológica de recolher outras informações técnicas, como o endereço de protocolo de Internet do Usuário, o sistema operacional do computador e etc.\n\n'
//
//
//                'Conforme já determinado anteriormente, a AETUR não fornecerá as informações do Usuário a terceiros sem prévia autorização do mesmo.\n\n'
//
//
//                'A AETUR poderá, a seu critério, fazer uso das informações armazenadas nos seus bancos de dados, conforme descrito acima, por um prazo razoável, sem que exceda os requisitos ou limitações legais, para dirimir quaisquer disputas, solucionar problemas e garantir os direitos da AETUR, assim como os termos e condições da presente Política de Privacidade.\n\n'
//
//
//                'A AETUR deverá também, a seu critério, examinar as informações armazenadas nos seus bancos de dados com o propósito de identificar Usuários com múltiplas identidades ou pseudônimos para fins legais e/ou de segurança. Em outra hipótese, se a AETUR for obrigada por lei, ordem judicial ou outro processo legal, a divulgar alguma informação pessoal do Usuário, não hesitará em cooperar com estes agentes. Assim, por meio deste instrumento, o Usuário autoriza a AETUR a divulgar estas informações pessoais para atender aos fins acima indicados.\n\n'
//
//
//                '3 – Permissão para AETUR processar informações sobre o Usuário\n\n'
//
//
//              'As informações cedidas pelo Usuário e registradas devido ao uso do sistema (com exceção ao conteúdo de mensagens pessoais) servirão como insumos para o mapeamento de informações de mercado e formação de estatísticas para a AETUR. Através do cadastramento, uso e fornecimento de informações a AETUR, o usuário deliberadamente aceita os Termos de Uso e condições da Política de Privacidade sobre o uso de suas informações.\n\n'
//
//
//            'As informações cedidas pelo Usuário que o torna pessoalmente identificável tem como único objetivo fazer com que os Usuários da AETUR se relacionem melhor com as ferramentas colocadas à sua disposição. Informações adicionais coletadas pela AETUR, através da análise da navegação de cada Usuário e que não o torne identificável pessoalmente, (como o padrão de navegação, por exemplo).\n\n'
//
//
//              'Além disso, as informações fornecidas são usadas para: (i) administrar a conta dos usuários a fim de customizar cada vez mais os serviços; e comunicar novidades e atualizações.\n\n'
//
//
//          '4 – Canal de Comunicação com o Usuário\n\n'
//
//
//            'Se o Usuário tiver qualquer dúvida ou sugestão sobre a AETUR, ele poderá encaminhar um e-mail para contato@cartaopec.com.br\n\n',
//                textAlign: TextAlign.justify,
//                style: TextStyle(color: Colors.grey[500], fontSize: 16),
//              ),
//            ),
//          ),
//        ],
//      )),
//    );
//  }
//}
