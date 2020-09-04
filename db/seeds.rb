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

Category.create([{name: 'Curas sanitarias básicas', supcategory: 'Atención a personas'},
                 {name: 'Cuidado del cuerpo', supcategory: 'Atención a personas'},
                 {name: 'Asesoramiento en maternidad y crianza', supcategory: 'Atención a personas'},
                 {name: 'Asesoramiento', supcategory: 'Atención a personas'},
                 {name: 'Atención y acompañamiento', supcategory: 'Atención a personas'},
                 {name: 'Encargos y gestiones', supcategory: 'Atención a personas'}])

Category.create([{name: 'Manejo de programas', supcategory: 'Informática'},
                 {name: 'Creación de webs', supcategory: 'Informática'},
                 {name: 'Clases', supcategory: 'Informática'},
                 {name: 'Programación', supcategory: 'Informática'},
                 {name: 'Reparación', supcategory: 'Informática'}])

Category.create([{name: 'Electrodomésticos', supcategory: 'Hogar'},
                 {name: 'Bricolaje', supcategory: 'Hogar'},
                 {name: 'Fontaneria', supcategory: 'Hogar'},
                 {name: 'Pintura', supcategory: 'Hogar'},
                 {name: 'Electricidad', supcategory: 'Hogar'},
                 {name: 'Obras', supcategory: 'Hogar'},
                 {name: 'Mudanza', supcategory: 'Hogar'},
                 {name: 'Mobiliario', supcategory: 'Hogar'},
                 {name: 'Limpieza', supcategory: 'Hogar'},
                 {name: 'Lavanderia', supcategory: 'Hogar'}])

Category.create([{name: 'Apoyo escolar', supcategory: 'Enseñanza'},
                 {name: 'Técnicas de estudio', supcategory: 'Enseñanza'},
                 {name: 'Lectoescritura', supcategory: 'Enseñanza'},
                 {name: 'Artes Plásticas', supcategory: 'Enseñanza'},
                 {name: 'Artes escénicas', supcategory: 'Enseñanza'},
                 {name: 'Música y canto', supcategory: 'Enseñanza'},
                 {name: 'Juegos de Mesa', supcategory: 'Enseñanza'},
                 {name: 'Manualidades', supcategory: 'Enseñanza'},
                 {name: 'Maquillaje', supcategory: 'Enseñanza'},
                 {name: 'Deportes', supcategory: 'Enseñanza'}])

Category.create([{name: 'Asesoramiento', supcategory: 'Huertos y Jardines'},
                 {name: 'Tareas de mantenimiento', supcategory: 'Huertos y Jardines'}])


Category.create([{name: 'Retoques', supcategory: 'Confección y retoques de ropa'},
                 {name: 'Confeción', supcategory: 'Confección y retoques de ropa'}])

Category.create([{name: 'Animales de compañia', supcategory: 'Animales Domésticos'},
                 {name: 'Animales de granja', supcategory: 'Animales Domésticos'}])

Category.create([{name: 'Bicicletas', supcategory: 'Mantenimiento y reparación de vehiculos'},
                 {name: 'Coches', supcategory: 'Mantenimiento y reparación de vehiculos'},
                 {name: 'Embarcaciones', supcategory: 'Mantenimiento y reparación de vehiculos'}])

Category.create([{name: 'Clases de cocina', supcategory: 'Cocina y Reposteria'},
                 {name: 'Elaboración', supcategory: 'Cocina y Reposteria'}])

Category.create([{name: 'Visitas culturales', supcategory: 'Ocio y tiempo libre'},
                 {name: 'Excursiones y senderismo', supcategory: 'Ocio y tiempo libre'},
                 {name: 'Juegos y actividades recreativas', supcategory: 'Ocio y tiempo libre'},
                 {name: 'Actuaciones y animación', supcategory: 'Ocio y tiempo libre'}])

Category.create([{name: 'Clases y conversación', supcategory: 'Idioma'},
                 {name: 'Trasucción y correción', supcategory: 'Idioma'}])

Category.create([{name: 'Conocimientos y habilidades de alrededor del mundo', supcategory: 'Interculturalidad'},
                 {name: 'Conocimientos sobre otros paises y lugares de interés', supcategory: 'Interculturalidad'},
                 {name: 'Conversación en diferentes idiomas', supcategory: 'Interculturalidad'}])