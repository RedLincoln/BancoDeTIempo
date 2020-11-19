<template>
  <v-simple-table class="m-5 elevation-2">
    <thead>
      <tr>
        <th>Estado de la petición</th>
        <th>Nombre de servicio</th>
        <th>Fecha, Hora y Duración</th>
        <th>Propietario</th>
        <th>Cliente</th>
        <th>Información</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="(petition, index) in petitions">
        <td>
          <v-chip>{{ formatStatus(petition.status) }}</v-chip>
        </td>
        <td>
          <router-link
            :to="{
              name: 'service-profile',
              params: { id: petition.service.id },
            }"
            >{{ petition.service.name }}
          </router-link>
        </td>
        <td>
          <p :class="durationColor(petition)" class="m-0">
            {{ petition.duration }} horas
          </p>
          <p class="m-0">{{ petition.datetime }}</p>
        </td>
        <td>
          <router-link
            :to="{ name: 'user-profile', params: { id: petition.owner.id } }"
            >{{ petition.owner.name }}
          </router-link>
        </td>
        <td>
          <router-link
            :to="{ name: 'user-profile', params: { id: petition.client.id } }"
            >{{ petition.client.name }}
          </router-link>
        </td>
        <td>
          <p>{{ petition.additional_information }}</p>
        </td>
        <td>
          <div class="d-flex flex-column justify-space-around">
            <v-btn
              v-if="isClient(petition) && isNegotiating(petition)"
              :to="{
                name: 'edit-service-petition',
                params: { id: petition.id },
              }"
              color="primary"
              small
              width="100px"
              >Editar</v-btn
            >
            <v-btn
              v-if="canCancel(petition)"
              @click="updatePetitionState(petition, 'canceled')"
              color="red"
              small
              width="100px"
              >Cancelar</v-btn
            >
            <v-btn
              v-if="canAccept(petition)"
              @click="updatePetitionState(petition, 'accepted')"
              color="green"
              small
              width="100px"
              >Aceptar</v-btn
            >
            <v-btn
              v-if="canNegotiate(petition)"
              @click="updatePetitionState(petition, 'negotiating')"
              color="warning"
              small
              width="100px"
              >Negociar</v-btn
            >
            <Rate
              :title="`Valora a ${petition.client.name}`"
              @rate="donePetition(petition.id, $event)"
            >
              <template v-slot:default="{ attrs, on }">
                <v-btn
                  v-if="canDone(petition)"
                  v-bind="attrs"
                  v-on="on"
                  small
                  width="100px"
                  >Realizar</v-btn
                >
              </template>
            </Rate>
            <Rate
              :title="`Valora a ${petition.owner.name}`"
              @rate="valuePetition(petition.id, $event)"
            >
              <template v-slot:default="{ attrs, on }">
                <v-btn
                  v-if="canValue(petition)"
                  v-bind="attrs"
                  v-on="on"
                  small
                  width="100px"
                  >Valorar</v-btn
                >
              </template>
            </Rate>
          </div>
        </td>
      </tr>
    </tbody>
  </v-simple-table>
</template>

<script>
import { mapGetters, mapState } from "vuex";
import Rate from "./Rate";
import PetitionService from "../services/petitions";

const { updatePetition, donePetition, valuePetition } = PetitionService;

export default {
  components: {
    Rate,
  },
  props: {
    client: {
      type: Boolean,
      defaut: false,
    },
    owner: {
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
      search: "",
      states: ["Negociación", "Aceptada", "Cancelada", "Realizada", "Valorada"],
      originalStates: ["negotiating", "accepted", "canceled", "done", "valued"],
    };
  },

  computed: {
    petitions() {
      if (this.client) {
        return this.clients(this.user_id);
      } else if (this.owner) {
        return this.owners(this.user_id);
      } else {
        return this.all;
      }
    },
    ...mapState("session", ["loggedIn", "user_id"]),
    ...mapGetters("petitions", ["all", "clients", "owners"]),
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
    isNegotiating(petition) {
      return petition.status === "negotiating";
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
