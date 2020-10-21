# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Message.destroy_all
ChatRoomUser.destroy_all
ChatRoom.destroy_all
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
                  {name: 'Confección', supcategory: 'Confección y retoques de ropa'}])

Category.create!([{name: 'Animales de compañía', supcategory: 'Animales Domésticos'},
                  {name: 'Animales de granja', supcategory: 'Animales Domésticos'}])

Category.create!([{name: 'Bicicletas', supcategory: 'Mantenimiento y reparación de vehículos'},
                  {name: 'Coches', supcategory: 'Mantenimiento y reparación de vehículos'},
                  {name: 'Embarcaciones', supcategory: 'Mantenimiento y reparación de vehículos'}])

Category.create!([{name: 'Clases de cocina', supcategory: 'Cocina y Repostería'},
                  {name: 'Elaboración', supcategory: 'Cocina y Repostería'}])

Category.create!([{name: 'Visitas culturales', supcategory: 'Ocio y tiempo libre'},
                  {name: 'Excursiones y senderismo', supcategory: 'Ocio y tiempo libre'},
                  {name: 'Juegos y actividades recreativas', supcategory: 'Ocio y tiempo libre'},
                  {name: 'Actuaciones y animación', supcategory: 'Ocio y tiempo libre'}])

Category.create!([{name: 'Clases y conversación', supcategory: 'Idioma'},
                  {name: 'Traducción y corrección', supcategory: 'Idioma'}])

Category.create!([{name: 'Conocimientos y habilidades de alrededor del mundo', supcategory: 'Interculturalidad'},
                  {name: 'Conocimientos sobre otros países y lugares de interés', supcategory: 'Interculturalidad'},
                  {name: 'Conversación en diferentes idiomas', supcategory: 'Interculturalidad'}])


Category.create!([{ name: 'Clases', supcategory: 'Clases'},
                  { name: 'Coaching', supcategory: 'Clases'}])

Category.create!({ name: 'Otros', supcategory: 'Otros' })


user1 = User.create!({name: 'Esteban', email: 'kmaclure0@adobe.com', password: 'GI2CyM', information: '', confirmed: true })
user1.avatar.attach(io: File.open("#{Rails.root}/seed_data/hombre1.jpg"), filename: "hombre1.jpg")
user2 = User.create!({name: 'Sergio', email: 'swalling1@nydailynews.com', password: 'mYxZ6ne6A', information: '', confirmed: true})
user2.avatar.attach(io: File.open("#{Rails.root}/seed_data/hombre2.jpg"), filename: "hombre2.jpg")
user3 = User.create!({name: 'Maria', email: 'vbalaisot2@example.com', password: 'x5pKgntnwqJ', information: '', confirmed: true})
user3.avatar.attach(io: File.open("#{Rails.root}/seed_data/mujer1.jpg"), filename: "mujer1.jpg")
user4 = User.create!({name: 'Yolanda', email: 'htweedle3@bing.com', password: '3l0i3qyBAWo', information: '', confirmed: true})
user4.avatar.attach(io: File.open("#{Rails.root}/seed_data/mujer2.jpg"), filename: "mujer2.jpg")
user5 = User.create!({name: 'Hanan', email: 'hstainton4@noaa.gov', password: 'wudJmkiN', information: '', confirmed: true})
user5.avatar.attach(io: File.open("#{Rails.root}/seed_data/mujer3.jpg"), filename: "mujer3.jpg")
user6 = User.create!({name: 'Aurora', email: 'adeleek5@narod.ru', password: 'bOSCTXIW21', information: '', confirmed: true})
user6.avatar.attach(io: File.open("#{Rails.root}/seed_data/mujer4.jpg"), filename: "mujer4.jpg")
user7 = User.create!({name: 'Agustin', email: 'jlamke6@irs.gov', password: 'a6KUZjSPKyWK', information: '', confirmed: true})
user7.avatar.attach(io: File.open("#{Rails.root}/seed_data/hombre3.jpg"), filename: "hombre3.jpg")
user8 = User.create!({name: 'Carlota', email: 'bedge117@soundcloud.com', password: 'gNP4HltfDdl', information: '', confirmed: true})
user8.avatar.attach(io: File.open("#{Rails.root}/seed_data/mujer5.jpg"), filename: "mujer5.jpg")
user9 = User.create!({name: 'Victor', email: 'cplunket8@washingtonpost.com', password: 'PMoPC35PKm', information: '', confirmed: true})
user9.avatar.attach(io: File.open("#{Rails.root}/seed_data/hombre4.jpg"), filename: "hombre4.jpg")
user10 = User.create!({name: 'Carlos', email: 'kharg9@dogondesign.com', password: 'Q7mTKEJh5N', information: '', confirmed: true})
user10.avatar.attach(io: File.open("#{Rails.root}/seed_data/hombre5.jpg"), filename: "hombre5.jpg")
user11 = User.create!({name: 'Yaiza', email: 'dmcteggart0@comsenz.com', password: 'T887wFR0TMe',
                       information: 'Podéis contactar conmigo por teléfono, estoy disponible por las mañanas', telephone: '559-852-2782'})
user11.avatar.attach(io: File.open("#{Rails.root}/seed_data/mujer7.jpg"), filename: "mujer7.jpg")

user12 = User.create!({name: 'Siddartha Roa Arias', email: 'bdikes1@spiegel.de', password: 'CFL1wC',
                      information: 'Profesional en Microbiología y Magister en Estudios y Gestión del Desarrollo con 11 '\
                                    'años de experiencia en el trabajo de campo con comunidades. Con habilidades en negociación, '\
                                    'manejo de entorno einteracción con comunidades. Conocimiento y experiencia en elaboración de '\
                                    'presupuestos y ejecución de estategías y planes de inversión social.',
                      confirmed: true, telephone: '921-602-7778'})
user12.avatar.attach(io: File.open("#{Rails.root}/seed_data/mujer8.jpg"), filename: "mujer8.jpg")

user13 = User.create!({name: 'Claudine Abdelnur', email: 'gdummett2@google.es', password: 'MFpt1Ac8Z',
                       information: 'Educadora, artista.', confirmed: true, telephone: '541-848-5928'})
user13.avatar.attach(io: File.open("#{Rails.root}/seed_data/mujer9.jpg"), filename: "mujer9.jpg")

user14 = User.create!({name: 'Marcos', email: 'ddeantoni3@ucoz.ru', password: 'hgPdVB', information: 'Profesor de inglés',
                       confirmed: true, telephone: '888-986-7191'})

user14.avatar.attach(io: File.open("#{Rails.root}/seed_data/hombre7.jpg"), filename: "hombre7.jpg")

admin1 = User.create!({name: 'Jesus', email: 'mchartea@issuu.com', password: '8cSAvouS', information: '', role: 'admin', confirmed: true})
admin1.avatar.attach(io: File.open("#{Rails.root}/seed_data/hombre6.jpg"), filename: "hombre6.jpg")
admin2 = User.create!({name: 'Esther', email: 'bscobleb@bbb.org', password: 'f7m3cUlwD7', information: '', role: 'admin', confirmed: true})
admin2.avatar.attach(io: File.open("#{Rails.root}/seed_data/mujer6.jpg"), filename: "mujer6.jpg")

programacion = Category.find_by!(name: 'Programación', supcategory: 'Informática')
mudanza = Category.find_by!(name: 'Mudanza', supcategory: 'Hogar')
deportes = Category.find_by!(name: 'Deportes', supcategory: 'Enseñanza')
apollo_escolar = Category.find_by!(name: 'Apoyo escolar', supcategory: 'Enseñanza')
clases_y_conversacion = Category.find_by!(name: 'Clases y conversación', supcategory: 'Idioma')
traduccion_y_correcion = Category.find_by!(name: 'Traducción y corrección', supcategory: 'Idioma')
jardines_asesoramiento = Category.find_by!(name: 'Asesoramiento', supcategory: 'Huertos y Jardines')
clases_de_cocina = Category.find_by!(name: 'Clases de cocina', supcategory: 'Cocina y Repostería')
reparacion_bicicletas = Category.find_by!(name: 'Bicicletas', supcategory: 'Mantenimiento y reparación de vehículos')
reparacion_coches = Category.find_by!(name: 'Coches', supcategory: 'Mantenimiento y reparación de vehículos')
creando_webs = Category.find_by!(name: 'Creación de webs', supcategory: 'Informática')
excursiones_y_senderismo = Category.find_by!(name: 'Excursiones y senderismo', supcategory: 'Ocio y tiempo libre')
animales_de_compania = Category.find_by!(name: 'Animales de compañía', supcategory: 'Animales Domésticos')
animales_de_granja = Category.find_by!(name: 'Animales de granja', supcategory: 'Animales Domésticos')
conocimiento_y_habilidades_de_alrededor_del_mundo = Category.find_by!(name: 'Conocimientos y habilidades de alrededor del mundo',
                                                                      supcategory: 'Interculturalidad')
musica_y_canto = Category.find_by!(name: 'Música y canto', supcategory: 'Enseñanza')
artes_escenicas = Category.find_by!(name: 'Artes escénicas', supcategory: 'Enseñanza')
elaboracion_cocina = Category.find_by!(name: 'Elaboración', supcategory: 'Cocina y Repostería')
clases = Category.find_by!(name: 'Clases', supcategory: 'Clases')
coaching = Category.find_by!(name: 'Coaching', supcategory: 'Clases')
clases_de_idiomas = Category.find_by!(name: 'Clases y conversación', supcategory: 'Idioma')
otros = Category.find_by!(name: 'Otros', supcategory: 'Otros')
cuidado_de_personas = Category.find_by!(name: 'Atención y acompañamiento', supcategory: 'Atención a personas')
ocio_juegos = Category.find_by!(name: 'Juegos y actividades recreativas', supcategory: 'Ocio y tiempo libre')

Service.create!([{name: 'Clases Básicas de programación',
                  description: 'Clases de nivel principiante. Está destinada para personas que siempre han querido'\
                              ' conocer como es el mundillo de la programación'\
                              ' pero nunca han tenido la oportunidad de probarlo.',
                  user: user2, category: programacion},

                 {name: 'Clases de Matemáticas', description: 'Clases de apoyo para alumnos de ESO y Bachillerato.',
                  user: user2, category: apollo_escolar},
                 {name: 'Crear webs', description: 'Creando webs fácil con herramientas como wix o webnode', user: user2, category: creando_webs}])

Service.create!([{name: 'El arte del desayuno',
                  description: 'Aprenderás a cocinar deliciosos desayunos y al mismo tiempo'\
                              'cuidarte mejor', user: user3, category: clases_de_cocina},
                 {name: 'Ayuda con mudanza', description: 'Ofrezco ayuda para mudanzas', user: user3, category: mudanza},
                 {name: 'Senderismo en la Caldera de Bandama',
                  description: 'Una ruta fácil para apreciar el precioso paisaje de Gran Canarias',
                  user: user3, category: excursiones_y_senderismo},
                 {name: 'Desde Fataga a la Fortaleza de Ansite',
                  description: 'Una de mis rutas favoritas, anímate a venir conmigo.', user: user3, category: excursiones_y_senderismo}])

Service.create!([{name: 'Sacándole partido a la programación',
                  description: 'La programación no tiene por que ser difícil para ser útil,'\
                              ' con pocas líneas de código puedes crear programas que te ayuden a'\
                              ' resolver problemas que te encuentras en el día a día.',
                  user: user4, category: programacion},
                 {name: 'Te ayudo con la mudanza!!', description: 'Siempre es bueno ayudar a los demás.',
                  user: user4, category: mudanza},
                 {name: 'Ayuda con entrenamiento de resistencia',
                  description: 'Soy un fanático de los maratones no me pierdo uno, si eres como yo o quieres probar te'\
                              ' sería un gusto ayudarte en lo que necesites.', user: user4, category: deportes}])

Service.create!([{name: 'Cuidado de perros y gatos',
                  description: 'Si algún día necesitas que te ayuden con tus animalitos no dudas en preguntar,'\
                              ' soy amante de los animales, especialmente de los perros.', user: user5, category: animales_de_compania},
                 {name: 'Cuidado de animales de granja',
                  description: 'He aprendido con mi tia algunas técnicas para cuidar y sacarles partido a los animales de'\
                              ' granja, me harias un favor si me permitieras ponerlos en práctica.'\
                              ' Gracias por adelantado :).', user: user5, category: animales_de_granja},
                 {name: 'Cultura de Japón',
                  description: 'He vivido en Japón unos cuantos años y la cultura ahí es muy diferente'\
                              ' a la del resto del mundo. Si te gustaría saber sobre el estilo de vida y cultura de este'\
                              ' fascinante país yo te puedo echar una mano.', user: user5, category: conocimiento_y_habilidades_de_alrededor_del_mundo},
                 {name: 'Clases de Java', description: 'Llevo años utilizando Java en mis proyectos y me gustaria tener'\
                                                      ' la posibilidad de compartir lo que se con los demás.', user: user5, category: programacion},
                 {name: 'Creación de Postres',
                  description: 'Te puedo enseñar a crear vacíos postres que sorprenderán a'\
                              ' familia y amigos.', user: user5, category: elaboracion_cocina},
                 {name: 'Clases de piano',
                  description: 'Te ofrezco la oportunidad de aprender a tocas el piano, no es necesario tener uno propio'\
                              ', utilizaremos el que tengo en mi casa.', user: user5, category: musica_y_canto}])


Service.create!([{name: 'Apoyo de Inglés',
                  description: 'Clases de apoyo de inglés para los estudiantes de la ESO.',
                  user: user9, category: apollo_escolar},
                 {name: 'Traducción de inglés',
                  description: 'Si necesitas ayuda para traducir algún tipo de texto(grande o pequeño)'\
                              ' del inglés a español o viceversa te puedo echar una mano y de paso aprendemos algo los dos',
                  user: user9, category: traduccion_y_correcion},
                 {name: 'Speaking de Ingles',
                  description: 'Sesiones de speaking de inglés para mejorar la pronunciación'\
                              ' y también el listening', user: user9, category: clases_y_conversacion}])

Service.create!([{name: 'Reparación de bicicletas',
                  description: 'Te ayudo a reparar tu bicicleta.', user: user10, category: reparacion_bicicletas},
                 {name: 'Reparación de coches',
                  description: 'Te ayudo a reparar tu coche.', user: user10, category: reparacion_coches}])

Service.create!({name: 'Ayuda con tu Jardín',
                 description: 'Te puedo ayudar a crear y mantener un precioso jardín en tu casa.',
                 user: user8, category: jardines_asesoramiento})


Service.create!([{ name: 'Pasear perros', description: 'Acompaño a los perros al parque', service_type: 'offer', user: user11, category: animales_de_compania},
                 { name: 'Clases de piano', description: 'Me encantaría aprender piano, necesito clases', service_type: 'demand', user: user11, category: musica_y_canto}])


Service.create!([{ name: 'Clases de banco de Tiempo', description: 'Aprender a usar el banco de tiempo', service_type: 'offer', user: user13, category: clases },
                 { name: 'Ahumo de arroz', description: 'Si necesitas la excusa perfecta para salir a cenas...No lo dudes.', service_type: 'offer', user: user13, category: elaboracion_cocina },
                 { name: 'Clases de música', description: 'Ofrezco cláses de música desde nivel inicial a avanzado', service_type: 'offer', user: user13, category: musica_y_canto },
                 { name: 'Taller de autoestima', description: 'Mediante técnicas prácticas te enseño a amarte a ti mismo', service_type: 'offer', user: user13, category: coaching },
                 { name: 'Clases de inglés', description: 'Busco clases de inglés para adultos, escritura y conversación nivel básico', service_type: 'demand', user: user13, category: clases_de_idiomas },
                 { name: 'Comprar regalo', description: 'Persona con gusto e imaginación para comprar un nuevo regalo, envolverlo y entregarlo', service_type: 'demand', user: user13, category: otros },
                 { name: 'Organización de fiesta', description: 'Organización de fiesta de cumpleaños', service_type: 'demand', user: user13, category: otros}])

Service.create!([{ name: 'Cuidado de personas mayores', description: 'Tengo 5 años de experiencia en el cuidado de personas mayores', service_type: 'offer', user: user14, category: cuidado_de_personas },
                 { name: 'Clases de inglés - B1, B2, C1', description: 'Preparo para exámenes oficiales B1, B2 y C1', service_type: 'offer', user: user14, category: clases_de_idiomas },
                 { name: 'Jugar al padel', description: 'Me gustaría probar', service_type: 'demand', user: user13, category: ocio_juegos},
                 { name: 'Busco clases particulares para mi hijo', description: ' Busco a una persona que dé clases particulares a mi hijo de 16 años',  service_type: 'demand', user: user14, category: clases}])


clases_basicas_de_programacion = Service.find_by!(name: 'Clases Básicas de programación') #1 user2
clases_de_matematicas = Service.find_by!(name: 'Clases de Matemáticas') #2 user2
crear_webs = Service.find_by!(name: 'Crear webs') #3 user2
el_arte_del_desayuno = Service.find_by!(name: 'El arte del desayuno') #4 user3
ayuda_con_mudanza = Service.find_by!(name: 'Ayuda con mudanza') #5 user3
senderismo_caldera = Service.find_by!(name: 'Senderismo en la Caldera de Bandama') #6 user3
senderismo_fataga_ansite = Service.find_by!(name: 'Desde Fataga a la Fortaleza de Ansite') #7 user3
sacandole_partido_a_la_programación = Service.find_by!(name: 'Sacándole partido a la programación') #8 user4
ayuda_con_la_mudanza = Service.find_by!(name: 'Te ayudo con la mudanza!!') #9 user4
entreno_de_resistencia = Service.find_by!(name: 'Ayuda con entrenamiento de resistencia') #10 user4
cuidado_perros_y_gatos = Service.find_by!(name: 'Cuidado de perros y gatos') #11 user5
cuidado_animales_granja = Service.find_by!(name: 'Cuidado de animales de granja') #12 user5
cultura_de_japon = Service.find_by!(name: 'Cultura de Japón') #13 user5
clases_de_java = Service.find_by!(name:'Clases de Java') #14 user5
creacion_de_postres = Service.find_by!(name: 'Creación de Postres') #15 user5
clases_de_piano = Service.find_by!(name: 'Clases de piano') #16 user5
apollo_ingles = Service.find_by!(name: 'Apoyo de Inglés') #17 user9
traduccion_ingles = Service.find_by!(name: 'Traducción de inglés') #18 user9
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
                      additional_information: 'Hola, te agradeceria ayuda con la mudanza, me hace mucha falta, gracias por adelantado',
                      client: user1, service: ayuda_con_la_mudanza},
                     {datetime: random_time, duration: random_duration,
                      additional_information: 'Hola, quiero entrenarme para un evento donde es necesario resistencia'\
                                            ' y agilidad, me puedes ayudar?.', client: user1, service: entreno_de_resistencia},
                     {datetime: random_time, duration: random_duration,
                      additional_information: 'Últimamente utilizo mucho la bicicleta y por lo tanto se me rompe mucho,'\
                                            ' me pregunto si me podrias enseñar a darle mantenimiento y a arreglar algunos problemas que tiene',
                      client: user1, service: reparacion_de_bicicletas}])

Transaction.create!([{datetime: random_time, duration: random_duration,
                      additional_information: 'Tengo varias gallinas y poco espacio, me puedes ayudar?',
                      client: user2, service: cuidado_animales_granja},
                     {datetime: random_time, duration: random_duration,
                      additional_information: 'Siempre me han gustado los postres pero nunca se me han dado bien hacerlos,'\
                                            ' según entiendo es importante saber las medidas exactas de las cantidades.'\
                                            ' Me podrias hechar un mano?', client: user2, service: creacion_de_postres},])

Transaction.create!([{datetime: random_time, duration: random_duration,
                      additional_information: 'Necesito alguien que cuide a mis animales de granja.'\
                                            ' Como no tengo mucho tiempo no puedo encargarme yo por ello'\
                                            ' me hace falta alguien a tiempo completo no solo un servicio de dos horas.'\
                                            ' Te interesa?', client: user3, service: cuidado_animales_granja}])

Transaction.create!([{datetime: random_time, duration: random_duration,
                      additional_information: 'Estoy estudiando japones para algun dia poder vivir en Japón.'\
                                            ' Me vendría muy bien tus conocimientos de Japón.',
                      client: user4, service: cultura_de_japon},
                     {datetime: random_time, duration: random_duration,
                      additional_information: 'Tengo varios textos que traducir para clase, el inglés se me da mal, me ayudas?',
                      client: user4, service: traduccion_ingles},
                     {datetime: random_time, duration: random_duration,
                      additional_information: 'Necesito la bicicleta para poder desplazarme y no tengo mucho dinero para'\
                                            'llevarla a reparar, me ayudas?',
                      client: user4, service: reparacion_de_bicicletas}])

Transaction.create!([{datetime: random_time, duration: random_duration,
                      additional_information: 'Es una ruta fácil?, soy principiante en senderismo pero me gusta mucho'\
                                             ' y me gustaría seguir probando',
                      client: user5, service: senderismo_fataga_ansite},
                     {datetime: random_time, duration: random_duration,
                      additional_information: 'Esto cansado de siempre desayunar tostadas con mermelada, necesito'\
                                            ' algo nuevo y delicioso',
                      client: user5, service: el_arte_del_desayuno},
                     {datetime: random_time, duration: random_duration,
                      additional_information: 'Me vendría bien practicar la pronunciación :)',
                      client: user5, service: speaking_ingles},
                     {datetime: random_time, duration: random_duration,
                      additional_information: 'Quiero probar un poco de programación para decidir si estudiar un ciclo'\
                                            ' de programación o no.',
                      client: user5, service: clases_basicas_de_programacion}])

Transaction.create!([{datetime: random_time, duration: random_duration,
                      additional_information: 'Tengo curiosidad de lo ofreces.',
                      client: user6, service: sacandole_partido_a_la_programación},
                     {datetime: random_time, duration: random_duration,
                      additional_information: 'Me voy de vacaciones a Japón dentro de poco y me gustaria saber si pudieras'\
                                            'darme algunos tips de cómo comportarse y cómo sacarle mejor partido al viaje.',
                      client: user6, service: cultura_de_japon},
                     {datetime: random_time, duration: random_duration,
                      additional_information: 'Seria un dia super ocupado y no tengo a nadie que saque a los perros a pasear'\
                                            ' te agradeceria que me ayudaras.',
                      client: user6, service: cuidado_perros_y_gatos},
                     {datetime: random_time, duration: random_duration,
                      additional_information: 'Me mudo dentro de poco y no tengo quien me eche una mano.',
                      client: user6, service: ayuda_con_mudanza}])

Transaction.create!({datetime: random_time, duration: random_duration,
                     additional_information: 'Estoy buscando un hobby nuevo, me gustaría probar la jardinería.',
                     client: user7, service: ayuda_con_jardin})

Transaction.create!([{datetime: random_time, duration: random_duration,
                      additional_information: 'Mi nivel de inglés es muy bajo y necesito que sea mejor.',
                      client: user8, service: apollo_ingles},
                     {datetime: random_time, duration: random_duration,
                      additional_information: 'Me vendría bien otro par de manos.',
                      client: user8, service: ayuda_con_mudanza}])

Transaction.create!([{datetime: random_time, duration: random_duration,
                      additional_information: 'Necesito aprender un desayuno fuerte para empezar el dia bien.',
                      client: user9, service: el_arte_del_desayuno},
                     {datetime: random_time, duration: random_duration,
                      additional_information: 'Mi intención no es saber reparar coches, pero sí me gustaría entender'\
                                            ' por que se rompen y como.',
                      client: user9, service: reparacion_de_coches},
                     {datetime: random_time, duration: random_duration,
                      additional_information: 'Me han regalado unos pollitos y no se que hacer con ellos.',
                      client: user9, service: cuidado_animales_granja}])


