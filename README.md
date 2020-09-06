# Prototipo de Banco de Tiempo Utilizando Rubo on Rails y Vuejs

![Test](https://github.com/RedLincoln/BancoDeTIempo/workflows/Test/badge.svg?branch=master)

## Pasos para montar el servidor en modo development

Estos pasos se realizaron en un maquina Linux.

- Clonar el repositorio [Vagrantfile_vueonrails](https://github.com/RedLincoln/Vagrantfile_vueonrails)

```
  git clone https://github.com/RedLincoln/Vagrantfile_vueonrails.git
```

- Entrar en el directorio

```
  cd Vagrantfile_vueonrails
```

- Clonamos este repositorio

```
  git clone https://github.com/RedLincoln/BancoDeTIempo.git
```

- Levantamos la máquina y provisionarla

```
  vagrant up
```

- Entrar en la máquina

```
  vagrant ssh -L 3000:localhost:3000
```

- Dentro de la máquina navegamos al directorio del proyecto
  (\$: implica estar dentro de la máquina)

```
  $: cd /vagrant/BancoDeTIempo
```

- Instalamos las dependencias de ruby y las de node

```
  bundle install
  yarn install
```

- Creamos base de datos y migramos

```
  rails db:create
  rails db:migrate
```

- (Opcional) Cargamos datos

```
  rails db:seed
```

- Montamos servidor

```
  rails s
```

- Comandos para ejecutar los tests

```
  rspec
  yarn test
```

## Posibles problemas

- Se hace uso de Docker para utilizar PostgresQL, si se tienen problemas con la base de datos asegurese de que el contenedor de docker esta inicializado.
