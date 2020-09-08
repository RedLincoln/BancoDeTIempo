# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Transaction.destroy_all
Service.destroy_all
Category.destroy_all
Notification.destroy_all
User.destroy_all

Category.create!([{name: 'Curas sanitarias básicas', supcategory: 'Atención a personas'},
                 {name: 'Cuidado del cuerpo', supcategory: 'Atención a personas'},
                 {name: 'Asesoramiento en maternidad y crianza', supcategory: 'Atención a personas'},
                 {name: 'Asesoramiento', supcategory: 'Atención a personas'},
                 {name: 'Atención y acompañamiento', supcategory: 'Atención a personas'},
                 {name: 'Encargos y gestiones', supcategory: 'Atención a personas'}])

Category.create!([{name: 'Manejo de programas', supcategory: 'Informática'},
                 {name: 'Creación de webs', supcategory: 'Informática'},
                 {name: 'Clases', supcategory: 'Informática'},
                 {name: 'Programación', supcategory: 'Informática'},
                 {name: 'Reparación', supcategory: 'Informática'}])

Category.create!([{name: 'Electrodomésticos', supcategory: 'Hogar'},
                 {name: 'Bricolaje', supcategory: 'Hogar'},
                 {name: 'Fontaneria', supcategory: 'Hogar'},
                 {name: 'Pintura', supcategory: 'Hogar'},
                 {name: 'Electricidad', supcategory: 'Hogar'},
                 {name: 'Obras', supcategory: 'Hogar'},
                 {name: 'Mudanza', supcategory: 'Hogar'},
                 {name: 'Mobiliario', supcategory: 'Hogar'},
                 {name: 'Limpieza', supcategory: 'Hogar'},
                 {name: 'Lavanderia', supcategory: 'Hogar'}])

Category.create!([{name: 'Apoyo escolar', supcategory: 'Enseñanza'},
                 {name: 'Técnicas de estudio', supcategory: 'Enseñanza'},
                 {name: 'Lectoescritura', supcategory: 'Enseñanza'},
                 {name: 'Artes Plásticas', supcategory: 'Enseñanza'},
                 {name: 'Artes escénicas', supcategory: 'Enseñanza'},
                 {name: 'Música y canto', supcategory: 'Enseñanza'},
                 {name: 'Juegos de Mesa', supcategory: 'Enseñanza'},
                 {name: 'Manualidades', supcategory: 'Enseñanza'},
                 {name: 'Maquillaje', supcategory: 'Enseñanza'},
                 {name: 'Deportes', supcategory: 'Enseñanza'}])

Category.create!([{name: 'Asesoramiento', supcategory: 'Huertos y Jardines'},
                 {name: 'Tareas de mantenimiento', supcategory: 'Huertos y Jardines'}])


Category.create!([{name: 'Retoques', supcategory: 'Confección y retoques de ropa'},
                 {name: 'Confeción', supcategory: 'Confección y retoques de ropa'}])

Category.create!([{name: 'Animales de compañia', supcategory: 'Animales Domésticos'},
                 {name: 'Animales de granja', supcategory: 'Animales Domésticos'}])

Category.create!([{name: 'Bicicletas', supcategory: 'Mantenimiento y reparación de vehiculos'},
                 {name: 'Coches', supcategory: 'Mantenimiento y reparación de vehiculos'},
                 {name: 'Embarcaciones', supcategory: 'Mantenimiento y reparación de vehiculos'}])

Category.create!([{name: 'Clases de cocina', supcategory: 'Cocina y Repostería'},
                 {name: 'Elaboración', supcategory: 'Cocina y Repostería'}])

Category.create!([{name: 'Visitas culturales', supcategory: 'Ocio y tiempo libre'},
                 {name: 'Excursiones y senderismo', supcategory: 'Ocio y tiempo libre'},
                 {name: 'Juegos y actividades recreativas', supcategory: 'Ocio y tiempo libre'},
                 {name: 'Actuaciones y animación', supcategory: 'Ocio y tiempo libre'}])

Category.create!([{name: 'Clases y conversación', supcategory: 'Idioma'},
                 {name: 'Traducción y correción', supcategory: 'Idioma'}])

Category.create!([{name: 'Conocimientos y habilidades de alrededor del mundo', supcategory: 'Interculturalidad'},
                 {name: 'Conocimientos sobre otros paises y lugares de interés', supcategory: 'Interculturalidad'},
                 {name: 'Conversación en diferentes idiomas', supcategory: 'Interculturalidad'}])


user1 = User.create!({name: 'Karrah', email: 'kmaclure0@adobe.com', password: 'GI2CyM', introduction: ''})
user2 = User.create!({name: 'Sully', email: 'swalling1@nydailynews.com', password: 'mYxZ6ne6A', introduction: ''})
user3 = User.create!({name: 'Vi', email: 'vbalaisot2@example.com', password: 'x5pKgntnwqJ', introduction: ''})
user4 = User.create!({name: 'Hamil', email: 'htweedle3@bing.com', password: '3l0i3qyBAWo', introduction: ''})
user5 = User.create!({name: 'Hanan', email: 'hstainton4@noaa.gov', password: 'wudJmkiN', introduction: ''})
user6 = User.create!({name: 'Adriena', email: 'adeleek5@narod.ru', password: 'bOSCTXIW21', introduction: ''})
user7 = User.create!({name: 'Jocelin', email: 'jlamke6@irs.gov', password: 'a6KUZjSPKyWK', introduction: ''})
user8 = User.create!({name: 'Barclay', email: 'bedge117@soundcloud.com', password: 'gNP4HltfDdl', introduction: ''})
user9 = User.create!({name: 'Coleen', email: 'cplunket8@washingtonpost.com', password: 'PMoPC35PKm', introduction: ''})
user10 = User.create!({name: 'Kaela', email: 'kharg9@dogondesign.com', password: 'Q7mTKEJh5N', introduction: ''})
admin1 = User.create!({name: 'Marten', email: 'mchartea@issuu.com', password: '8cSAvouS', introduction: '', role: 'admin'})
admin2 = User.create!({name: 'Bogart', email: 'bscobleb@bbb.org', password: 'f7m3cUlwD7', introduction: '', role: 'admin'})

programacion = Category.find_by!(name: 'Programación', supcategory: 'Informática')
mudanza = Category.find_by!(name: 'Mudanza', supcategory: 'Hogar')
deportes = Category.find_by!(name: 'Deportes', supcategory: 'Enseñanza')
apollo_escolar = Category.find_by!(name: 'Apoyo escolar', supcategory: 'Enseñanza')
clases_y_conversacion = Category.find_by!(name: 'Clases y conversación', supcategory: 'Idioma')
traduccion_y_correcion = Category.find_by!(name: 'Traducción y correción', supcategory: 'Idioma')
jardines_asesoramiento = Category.find_by!(name: 'Asesoramiento', supcategory: 'Huertos y Jardines')
clases_de_cocina = Category.find_by!(name: 'Clases de cocina', supcategory: 'Cocina y Repostería')
reparacion_bicicletas = Category.find_by!(name: 'Bicicletas', supcategory: 'Mantenimiento y reparación de vehiculos')
reparacion_coches = Category.find_by!(name: 'Coches', supcategory: 'Mantenimiento y reparación de vehiculos')
creando_webs = Category.find_by!(name: 'Creación de webs', supcategory: 'Informática')
excursiones_y_senderismo = Category.find_by!(name: 'Excursiones y senderismo', supcategory: 'Ocio y tiempo libre')
animales_de_compania = Category.find_by!(name: 'Animales de compañia', supcategory: 'Animales Domésticos')
animales_de_granja = Category.find_by!(name: 'Animales de granja', supcategory: 'Animales Domésticos')
conocimiento_y_habilidades_de_alrededor_del_mundo = Category.find_by!(name: 'Conocimientos y habilidades de alrededor del mundo',
                                                                     supcategory: 'Interculturalidad')
musica_y_canto = Category.find_by!(name: 'Música y canto', supcategory: 'Enseñanza')
artes_escenicas = Category.find_by!(name: 'Artes escénicas', supcategory: 'Enseñanza')
elaboracion_cocina = Category.find_by!(name: 'Elaboración', supcategory: 'Cocina y Repostería')

Service.create!([{name: 'Clases Básicas de programación',
                 description: 'Clases de nivel principiante. Esta destinada para personas que siempre han querido'\
                              ' conocer como es el mundillo de la programación'\
                              ' pero nunca han tenido la oportunidad de probarlo.',
                 user: user2, category: programacion},

                {name: 'Clases de Matemáticas', description: 'Clases de apollo para alumnos de ESO y Barchillerato.',
                 user: user2, category: apollo_escolar},
                {name: 'Crear webs', description: 'Creando webs facil con herramientas como wix o webnode', user: user2, category: creando_webs}])

Service.create!([{name: 'El arte del desayuno',
                 description: 'Aprenderas a cocinar deliciosos desayunos y al mismo tiempo'\
                              'cuidarte mejor', user: user3, category: clases_de_cocina},
                {name: 'Ayuda con mudanza', description: 'Ofresco ayuda para mudanzas', user: user3, category: mudanza},
                {name: 'Senderismo en la Caldera de Bandama',
                 description: 'Una ruta fácil para apreciar el precioso paisaje de Gran Canarias',
                 user: user3, category: excursiones_y_senderismo},
                {name: 'Desde Fataga a la Fortaleza de Ansite',
                 description: 'Una de mis rutas favoritas, animate a venir conmigo.', user: user3, category: excursiones_y_senderismo}])

Service.create!([{name: 'Sacándole partido a la programación',
                 description: 'La programación no tiene por que ser difícil para ser util,'\
                              ' con pocas líneas de código puedes crear programas que te ayuden a'\
                              ' resolver problemas que te encuetras en el día a día.',
                 user: user4, category: programacion},
                {name: 'Te ayudo con la mundanza!!', description: 'Siempre es bueno ayudar a los demas.',
                 user: user4, category: mudanza},
                {name: 'Ayuda con entrenamiento de resistencia',
                 description: 'Soy un fanático de los maratones no me pierdo uno, si eres como yo o quieres probar te'\
                              ' sería un gusto ayudarte en lo que necesites.', user: user4, category: deportes}])

Service.create!([{name: 'Cuidado de perros y gatos',
                 description: 'Si algún dia necesitas que te ayuden con tus animalitos no dudas en preguntar,'\
                              ' soy amante de los animales, especialmente de los perros.', user: user5, category: animales_de_compania},
                {name: 'Cuidado de animales de granja',
                 description: 'He aprendido con mi tia algunas técnicas para cuidar y sacarles partido a los animales de'\
                              ' granja, me harias un favor si me permitieras ponerlos en práctica.'\
                              ' Gracias por adelantado :).', user: user5, category: animales_de_granja},
                {name: 'Cultura de Japón',
                 description: 'He vivido en Japón unos cuantos años y la cultura ahí es muy diferente'\
                              ' a la del resto del mundo. Si te gustria saber sobre el estilo de vida y cultura de este'\
                              ' fascinante país yo te puedo hechar una mano.', user: user5, category: conocimiento_y_habilidades_de_alrededor_del_mundo},
                {name: 'Clases de Java', description: 'Llevo años utilizando Java en mis proyectos y me gustaria tener'\
                                                      ' la posibilidad de compartir lo que se con los demás.', user: user5, category: programacion},
                {name: 'Creación de Postres',
                 description: 'Te puedo enseñar a crear vacios postres que sorprenderan a'\
                              ' familia y amigos.', user: user5, category: elaboracion_cocina},
                {name: 'Clases de piano',
                 description: 'Te ofresco la oportunidad de aprender a tocas el piano, no es necesario tener uno propio'\
                              ', utilizaremos el que tengo en mi casa.', user: user5, category: musica_y_canto}])


Service.create!([{name: 'Apollo de Ingles',
                 description: 'Clases de apollo de ingles para los estudiantes de la ESO.',
                 user: user9, category: apollo_escolar},
                {name: 'Traducción de ingles',
                 description: 'Si necesitas ayuda para traducir algun tipo de texto(grande o pequeño)'\
                              ' del ingles a español o viceversa te puedo echar una mano y de paso aprendemos algo los dos',
                 user: user9, category: traduccion_y_correcion},
                {name: 'Speaking de Ingles',
                 description: 'Sesiones de speaking de ingles para mejorar la pronunciación'\
                              ' y también el listening', user: user9, category: clases_y_conversacion}])

Service.create!([{name: 'Reparación de bicicletas',
                 description: 'Te ayudo a reparar tu bicicleta.', user: user10, category: reparacion_bicicletas},
                {name: 'Reparación de coches',
                 description: 'Te ayudo a reparar tu coche.', user: user10, category: reparacion_coches}])

Service.create!({name: 'Ayuda con tu Jardín',
                description: 'Te puedo ayudar a crear y matener un precioso jardin en tu casa.',
                user: user8, category: jardines_asesoramiento})

clases_basicas_de_programacion = Service.find_by!(name: 'Clases Básicas de programación') #1 user2
clases_de_matematicas = Service.find_by!(name: 'Clases de Matemáticas') #2 user2
crear_webs = Service.find_by!(name: 'Crear webs') #3 user2
el_arte_del_desayuno = Service.find_by!(name: 'El arte del desayuno') #4 user3
ayuda_con_mudanza = Service.find_by!(name: 'Ayuda con mudanza') #5 user3
senderismo_caldera = Service.find_by!(name: 'Senderismo en la Caldera de Bandama') #6 user3
senderismo_fataga_ansite = Service.find_by!(name: 'Desde Fataga a la Fortaleza de Ansite') #7 user3
sacandole_partido_a_la_programación = Service.find_by!(name: 'Sacándole partido a la programación') #8 user4
ayuda_con_la_mudanza = Service.find_by!(name: 'Te ayudo con la mundanza!!') #9 user4
entreno_de_resistencia = Service.find_by!(name: 'Ayuda con entrenamiento de resistencia') #10 user4
cuidado_perros_y_gatos = Service.find_by!(name: 'Cuidado de perros y gatos') #11 user5
cuidado_animales_granja = Service.find_by!(name: 'Cuidado de animales de granja') #12 user5
cultura_de_japon = Service.find_by!(name: 'Cultura de Japón') #13 user5
clases_de_java = Service.find_by!(name:'Clases de Java') #14 user5
creacion_de_postres = Service.find_by!(name: 'Creación de Postres') #15 user5
clases_de_piano = Service.find_by!(name: 'Clases de piano') #16 user5
apollo_ingles = Service.find_by!(name: 'Apollo de Ingles') #17 user9
traduccion_ingles = Service.find_by!(name: 'Traducción de ingles') #18 user9
speaking_ingles = Service.find_by!(name: 'Speaking de Ingles') #19 user9
reparacion_de_bicicletas = Service.find_by!(name: 'Reparación de bicicletas') #20 user10
reparacion_de_coches = Service.find_by!(name: 'Reparación de coches') #21 user10
ayuda_con_jardin = Service.find_by!(name: 'Ayuda con tu Jardín') #22 user8

def rand_in_range(from, to)
  rand * (to - from) + from
end

def random_int(from, to)
  rand_in_range(from, to).to_i
end

def random_duration
  random_int(1, 10)
end

def random_time
  random_days = random_int(1, 20)
  random_hours = random_int(8, 20)
  random_minutes = random_int(0, 59)

  (random_days.day + random_hours.hour + random_minutes.minutes).since
end

Transaction.create!([{datetime: random_time, duration: random_duration,
                      addition_information: 'Hola, te agradeceria ayuda con la mudanza, me hace mucha falta, gracias por adelantado',
                      client: user1, service: ayuda_con_la_mudanza},
                     {datetime: random_time, duration: random_duration,
                      addition_information: 'Hola, quiero entrenarme para un evento dende es necesario resistencia'\
                                            ' y agilidad, me puedes ayudar?.', client: user1, service: entreno_de_resistencia},
                     {datetime: random_time, duration: random_duration,
                      addition_information: 'Ultimamente utilizo mucho la bicicleta y por lo tanto se me rompe mucho,'\
                                            ' me pregunto si me podrias enseñar a darle mantenimiento y a arreglar algunos problemas que tiene',
                      client: user1, service: reparacion_de_bicicletas}])

Transaction.create!([{datetime: random_time, duration: random_duration,
                      addition_information: 'Tengo varias gallinas y poco espacio, me puedes ayudar?',
                      client: user2, service: cuidado_animales_granja},
                     {datetime: random_time, duration: random_duration,
                      addition_information: 'Siempre me han gustado los postres pero nunca se me han dado bien hacerlos,'\
                                            ' segun entiendo es importante saber las medidas exactas de las cantidades.'\
                                            ' Me podrias hechar un mano?', client: user2, service: creacion_de_postres},])

Transaction.create!([{datetime: random_time, duration: random_duration,
                      addition_information: 'Necesito alguien que cuide a mis animales de granja.'\
                                            ' Como no tengo mucho tiempo no puedo encargarme yo por ello'\
                                            ' me hace falta alguien a tiempo completo no solo un servicio de dos horas.'\
                                            ' Te interesa?', client: user3, service: cuidado_animales_granja}])

Transaction.create!([{datetime: random_time, duration: random_duration,
                      addition_information: 'Estoy estudiando japones para algun dia poder vivir en Japón.'\
                                            ' Me vendria muy bien tus conociemientos de Japón.',
                      client: user4, service: cultura_de_japon},
                     {datetime: random_time, duration: random_duration,
                      addition_information: 'Tengo varios textos que traducir para clase, el ingles se me da mal, me ayudas?',
                      client: user4, service: traduccion_ingles},
                     {datetime: random_time, duration: random_duration,
                      addition_information: 'Necesito la bicicleta para poder desplazarme y no tengo mucho dinero para'\
                                            'llevarla a reparar, me ayudas?',
                      client: user4, service: reparacion_de_bicicletas}])

Transaction.create!([{datetime: random_time, duration: random_duration,
                      addition_information: 'Es una ruta fácil?, soy principiante en senderismo pero me gusta mucho'\
                                             ' y me gustaria seguir probando',
                      client: user5, service: senderismo_fataga_ansite},
                     {datetime: random_time, duration: random_duration,
                      addition_information: 'Esto cansado de siempre desayunar tostadas con mermelada, necesito'\
                                            ' algo nuevo y delicioso',
                      client: user5, service: el_arte_del_desayuno},
                     {datetime: random_time, duration: random_duration,
                      addition_information: 'Me vendria bien prácticas la pronunciación :)',
                      client: user5, service: speaking_ingles},
                     {datetime: random_time, duration: random_duration,
                      addition_information: 'Quiero probar un poco de programación para decidirme si estudiar un ciclo'\
                                            ' de programación o no.',
                      client: user5, service: clases_basicas_de_programacion}])

Transaction.create!([{datetime: random_time, duration: random_duration,
                      addition_information: 'Tengo curiosidad de lo ofreces.',
                      client: user6, service: sacandole_partido_a_la_programación},
                     {datetime: random_time, duration: random_duration,
                      addition_information: 'Me voy de vacaciones a Japón dentro de poco y me gustaria saber si pudieras'\
                                            'darme algunos tips de como comportarme y como sacarle mejor partido al viaje.',
                      client: user6, service: cultura_de_japon},
                     {datetime: random_time, duration: random_duration,
                      addition_information: 'Seria un dia super ocupado y no tengo a nadie que saque a los perros a pasear'\
                                            ' te agradeceria que me ayudaras.',
                      client: user6, service: cuidado_perros_y_gatos},
                     {datetime: random_time, duration: random_duration,
                      addition_information: 'Me mudo dentro de poco y no tengo quien me heche una mano.',
                      client: user6, service: ayuda_con_mudanza}])

Transaction.create!({datetime: random_time, duration: random_duration,
                     addition_information: 'Estoy buscando un hobby nuevo, me gustaría probar la jardineria.',
                     client: user7, service: ayuda_con_jardin})

Transaction.create!([{datetime: random_time, duration: random_duration,
                      addition_information: 'Mi nivel de ingles es muy bajo y necesito que sea mejor.',
                      client: user8, service: apollo_ingles},
                     {datetime: random_time, duration: random_duration,
                      addition_information: 'Me vendria bien otro par de manos.',
                      client: user8, service: ayuda_con_mudanza}])

Transaction.create!([{datetime: random_time, duration: random_duration,
                      addition_information: 'Necesito aprender un desayuno fuerto para empezar el dia bien.',
                      client: user9, service: el_arte_del_desayuno},
                     {datetime: random_time, duration: random_duration,
                      addition_information: 'Mi intención no es saber reparar coches, pero si me gustaría entender'\
                                            ' por que se rompen y como.',
                      client: user9, service: reparacion_de_coches},
                     {datetime: random_time, duration: random_duration,
                      addition_information: 'Me han regalado unos pollitos y no se que hacer con ellos.',
                      client: user9, service: cuidado_animales_granja}])
