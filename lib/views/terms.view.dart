import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TermsView extends StatelessWidget {
  final TextStyle _titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TERMINOS Y CONDICIONES',
                  style: _titleStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'La presente política de privacidad (en adelante: La Política) tiene por finalidad informarle la manera en que BEBIDAS PREMIUM S.A.C., con R.U.C. N° 20556319058, con domicilio en Av. Paseo de la Republica Nro. 3617 (oficina 701), San Isidro, provincia y departamento de Lima – Perú, trata la información y datos personales de sus usuarios que recopila a través del sitio web, redes sociales, formularios digitales, así como cualquier medio electrónico o digital equivalente. La Política describe toda la tipología de información que se recaba de los usuarios en los distintos puntos de captación anteriormente detallados y todos los tratamientos que se realizan con dicha información. El Usuario declara haber leído y aceptado de manera previa y expresa la Política sujetándose a sus disposiciones.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Para efectos de esta Política toda referencia a “nos”, “nosotros” o “nuestra”, se refiere a BEBIDAS PREMIUM S.A.C., y cuando se refiera a “el Usuario” o “los Usuarios”, se entenderá a todos aquellos que naveguen, ingresen, revisen, realicen transacciones, interactúen o generen contenido dentro del sitio Web.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '¿QUÉ INFORMACIÓN RECOLECTAMOS?',
                  style: _titleStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'El Usuario puede navegar en el sitio Web libremente sin necesidad de registrarse y/o suscribirse. Sin embargo, en algunos casos se requerirá del registro y/o suscripción para acceder al contenido y el Usuario deberá completar un formulario proporcionando los datos personales solicitados.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Asimismo, existen determinadas secciones dentro del sitio Web en las que el Usuario puede crear o generar contenido, como las zonas de comentarios, servicio al cliente, etc. En dichos casos, también se solicitará el registro del Usuario a través del llenado de un formulario proporcionando los datos personales solicitados.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Recopilamos información del Usuario: Datos personales que el Usuario proporcione libremente cuando se registra o suscribe al Sitio Web, tales como nombre, apellido, dirección de correo electrónico, número de DNI, entre otros (los “Datos personales”).',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'SOBRE LA VERACIDAD DE LOS DATOS PERSONALES',
                  style: _titleStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'El Usuario declara que toda información proporcionada es verdadera, completa y exacta. Cada Usuario es responsable por la veracidad, exactitud, vigencia y autenticidad de la información suministrada, y se compromete a mantenerla debidamente actualizada.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'INCORPORACIÓN DE LA INFORMACIÓN DEL USUARIO EN UN BANCO DE DATOS',
                  style: _titleStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'De acuerdo a lo establecido en la Ley N° 29733, Ley de Protección de Datos Personales, y el Decreto Supremo N° 003-2013-JUS, por el que se aprueba su Reglamento, BEBIDAS PREMIUM S.A.C. informa a los Usuarios del Sitios Web que la Información del Usuario será incorporada a su banco de información.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'A través de la presente Política de Privacidad el Usuario da su consentimiento expreso para la inclusión de su información en los mencionados bancos de datos.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '¿PARA QUÉ UTILIZAMOS LA INFORMACIÓN DEL USUARIO?',
                  style: _titleStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'La Información del Usuario será tratada a fin de:',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Atender y procesar solicitudes de registro y/o suscripción de Usuarios, brindar soporte al Usuario, validar la veracidad de la información proporcionada y atender consultas del Usuario.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Gestionar los concursos y promociones que se realicen con los Usuarios. Informar sobre los ganadores de premios, promociones, concursos y/o sorteos realizados. Los Usuarios que participen en las promociones, concursos o sorteos mencionados, autorizan expresamente a que BEBIDAS PREMIUM S.A.C. utilice de manera gratuita y por los medios que estime convenientes, los datos personales e imágenes de los ganadores.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Transferir la Información del Usuario a empresas que brinden servicios basados en infraestructura en la nube en el extranjero, a fin de poder alojar, almacenar, procesar y ejecutar la Información del Usuario.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Tratamiento con fines comerciales, publicitarios y/o promocionales con las siguientes finalidades:',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '(i) Realizar estudios internos sobre los intereses, comportamientos y hábitos de conducta de los Usuarios a fin de poder enriquecer y complementar la Información del Usuario y de este modo ofrecer a los Usuarios un mejor servicio de acuerdo a sus necesidades específicas. Ello permitirá el envío de contenido personalizado sobre la base de sus intereses, ya sea a través del sitio web, como a través de otros medios no electrónicos.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '¿CÓMO RESGUARDAMOS LA INFORMACIÓN DEL USUARIO?',
                  style: _titleStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'BEBIDAS PREMIUM S.A.C. adopta las medidas técnicas y organizativas necesarias para garantizar la protección de la Información del Usuario y evitar su alteración, pérdida, tratamiento y/o acceso no autorizado, habida cuenta del estado de la técnica, la naturaleza de los datos almacenados y los riesgos a que están expuestos, todo ello, conforme a lo establecido por la Ley de Protección de Datos Personales, su Reglamento y la Directiva de Seguridad.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'En este sentido, BEBIDAS PREMIUM S.A.C. usará los estándares de la industria en materia de protección de la confidencialidad de la Información del Usuario.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'BEBIDAS PREMIUM S.A.C. emplea diversas técnicas de seguridad para proteger tales datos de accesos no autorizados. Sin perjuicio de ello, BEBIDAS PREMIUM S.A.C. no se hace responsable por interceptaciones ilegales o violación de sus sistemas o bases de datos por parte de personas no autorizadas, así como la indebida utilización de la información obtenida por esos medios, o de cualquier intromisión ilegítima que escape al control de BEBIDAS PREMIUM S.A.C. y que no le sea imputable.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'BEBIDAS PREMIUM S.A.C. tampoco se hace responsable de posibles daños o perjuicios que se pudieran derivar de interferencias, omisiones, interrupciones, virus informáticos, averías telefónicas o desconexiones en el funcionamiento operativo de este sistema electrónico, motivadas por causas ajenas a BEBIDAS PREMIUM S.A.C.; de retrasos o bloqueos en el uso de la plataforma informática causados por deficiencias o sobrecargas en el Centro de Procesos de Datos, en el sistema de Internet o en otros sistemas electrónicos.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'INFORMACIÓN DEL USUARIO SOLICITADA POR AUTORIDADES PÚBLICAS',
                  style: _titleStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'BEBIDAS PREMIUM S.A.C. se compromete a no divulgar o compartir la Información del Usuario sin que se haya prestado el debido consentimiento para ello, con excepción de los siguientes casos:',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '- Solicitud de información de autoridades públicas en ejercicio de sus funciones y el ámbito de sus competencias.\n- Solicitud de información en virtud de órdenes judiciales.\n- Solicitud de información en virtud de disposiciones legales.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'MODIFICACIONES DE LAS POLÍTICAS DE PRIVACIDAD',
                  style: _titleStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'BEBIDAS PREMIUM S.A.C. se reserva expresamente el derecho a modificar, actualizar o completar en cualquier momento la presente Política.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Cualquier modificación, actualización o ampliación producida en la presente Política será inmediatamente publicada en los Sitios Web y las Aplicaciones y se le solicitará su aceptación al ingresar a las mismas.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Fecha de última actualización: 14/09/2020.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
