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
