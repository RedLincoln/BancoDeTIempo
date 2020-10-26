<template>
  <v-data-table
    :headers="headers"
    :items="filteredPetitions"
    :items-per-page="10"
    class="elevation-1"
    :search="search"
  >
    <template v-slot:top>
      <v-row justify="center">
        <v-col cols="8" md="6">
          <v-text-field
            prepend-inner-icon="mdi-magnify"
            v-model="search"
            placeholder="Buscar Petición"
            filled
            rounded
          ></v-text-field>
          <v-btn text @click="tools = !tools"
            ><v-icon>mdi-tools</v-icon>Herramientas</v-btn
          >
          <v-scroll-y-transition>
            <v-sheet v-if="tools">
              <v-autocomplete
                v-model="statusFilter"
                :items="states"
                placeholder="Filtrar Categoría"
                solo
                clearable
              ></v-autocomplete>
            </v-sheet>
          </v-scroll-y-transition>
        </v-col>
      </v-row>
    </template>
    <template v-if="!isSpecific" v-slot:item.status="{ item }">
      <v-chip>{{ formatStatus(item.status) }}</v-chip>
    </template>
    <template v-slot:item.datetime="{ item }">
      <p :class="durationColor(item)" class="m-0">{{ item.duration }} horas</p>
      <p class="m-0">{{ item.datetime }}</p>
    </template>
    <template v-slot:item.name="{ item }">
      <router-link
        v-if="loggedIn"
        :to="{ name: 'service-profile', params: { id: item.service.id } }"
        >{{ item.service.name }}
      </router-link>
      <span v-else>{{ item.name }}</span>
    </template>
    <template v-slot:item.owner="{ item }">
      <router-link
        v-if="loggedIn"
        :to="{ name: 'user-profile', params: { id: item.owner.id } }"
        >{{ item.owner.name }}
      </router-link>
      <span v-else>{{ item.owner.name }}</span>
    </template>
    <template v-slot:item.client="{ item }">
      <router-link
        v-if="loggedIn"
        :to="{ name: 'user-profile', params: { id: item.client.id } }"
        >{{ item.client.name }}
      </router-link>
      <span v-else>{{ item.client.name }}</span>
    </template>
    <template v-slot:item.actions="{ item }">
      <v-btn
        v-if="isClient(item)"
        :to="{ name: 'edit-service-petition', params: { id: item.id } }"
        color="primary"
        small
        >Editar</v-btn
      >
      <v-btn
        v-if="canCancel(item)"
        @click="updatePetitionState(item, 'canceled')"
        color="red"
        small
        >Cancelar</v-btn
      >
      <v-btn
        v-if="canAccept(item)"
        @click="updatePetitionState(item, 'accepted')"
        color="green"
        small
        >Aceptar</v-btn
      >
      <v-btn
        v-if="canNegotiate(item)"
        @click="updatePetitionState(item, 'negotiating')"
        color="warning"
        small
        >Negociar</v-btn
      >
      <Rate
        :title="`Valora a ${item.client.name}`"
        @rate="donePetition(item.id, $event)"
      >
        <template v-slot:default="{ attrs, on }">
          <v-btn v-if="canDone(item)" v-bind="attrs" v-on="on" small
            >Realizar</v-btn
          >
        </template>
      </Rate>
      <Rate
        :title="`Valora a ${item.owner.name}`"
        @rate="valuePetition(item.id, $event)"
      >
        <template v-slot:default="{ attrs, on }">
          <v-btn v-if="canValue(item)" v-bind="attrs" v-on="on" small
            >Valorar</v-btn
          >
        </template>
      </Rate>
    </template>
  </v-data-table>
</template>

<script>
import { mapState } from "vuex";
import Rate from "./Rate";
import PetitionService from "../services/petitions";

const { updatePetition, donePetition, valuePetition } = PetitionService;

export default {
  components: {
    Rate,
  },
  props: {
    inputPetitions: {
      type: Array,
      required: true,
    },
    isSpecific: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      doneDialog: false,
      valuedDialog: false,
      rating: 4,
      ratingMessage: "",
      petitions: this.inputPetitions,
      filteredPetitions: this.inputPetitions,
      statusFilter: "",
      tools: false,
      search: "",
      headers: [],
      states: ["Negociación", "Aceptada", "Cancelada", "Realizada", "Valorada"],
      originalStates: ["negotiating", "accepted", "canceled", "done", "valued"],
    };
  },
  watch: {
    statusFilter(val) {
      if (val) {
        this.filteredPetitions = this.petitions.filter(
          (petition) =>
            petition.status === this.originalStates[this.states.indexOf(val)]
        );
      } else {
        this.filteredPetitions = this.petitions;
      }
    },
  },
  created() {
    const headers = [
      {
        text: "Nombre de Servicio",
        align: "start",
        sortable: false,
        value: "name",
      },
      { text: "Fechar, Hora y Duración", value: "datetime", align: "center" },
      { text: "Propietario", align: "start", value: "owner" },
      { text: "Client", align: "start", value: "client" },
      { text: "Información", value: "additional_information" },
      { value: "actions", align: "center" },
    ];
    if (!this.isSpecific) {
      headers.unshift({
        text: "Estado del la petición",
        value: "status",
        align: "center",
      });
    }
    this.headers = headers;
  },
  computed: {
    ...mapState("session", ["loggedIn", "user_id"]),
  },
  methods: {
    canCancel(petition) {
      return (
        petition.status === "negotiating" || petition.status === "accepted"
      );
    },
    canAccept(petition) {
      return petition.status === "negotiating" && !this.isClient(petition);
    },
    canNegotiate(petition) {
      return petition.status === "accepted";
    },
    canDone(petition) {
      return petition.status === "accepted" && !this.isClient(petition);
    },
    canValue(petition) {
      return petition.status === "done" && this.isClient(petition);
    },
    durationColor(petition) {
      return this.isClient(petition) ? "red--text" : "green--text";
    },
    updatePetitionState(petition, status) {
      updatePetition({
        id: petition.id,
        params: {
          status,
        },
      }).then((response) => {
        this.petitions.map((p) => {
          if (p.id === petition.id) {
            p.status = status;
          }
          return p;
        });
      });
    },
    isClient(petition) {
      return this.user_id === petition.client.id;
    },
    formatStatus(status) {
      switch (status) {
        case "negotiating":
          return "Negociación";
        case "accepted":
          return "Aceptada";
        case "canceled":
          return "Cancelada";
        case "done":
          return "Realizada";
        case "valued":
          return "Valorada";
      }
    },
    donePetition(id, rating) {
      donePetition(id, rating).then((response) => {
        this.petitions.map((p) => {
          if (p.id === id) {
            p.status = "done";
          }
          return p;
        });
      });
    },
    valuePetition(id, rating) {
      valuePetition(id, rating).then((response) => {
        this.petitions.map((p) => {
          if (p.id === id) {
            p.status = "valued";
          }
          return p;
        });
      });
    },
  },
};
</script>

<style></style>
