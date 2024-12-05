<template>
  <div class="column"
       :id="id"
       @dragover.prevent="onDragOver"
       @drop="onDrop"
  >
    <h2 class="columnTitle">{{ title }}</h2>
    <div class="cards">
      <KanbanCard
          v-for="(card, index) in cards"
          :key="card.id"
          :card="card"
          :index="index"
          :columnIndex="id"
          draggable="true"
          @dragStart="onDragStart(card, index)"
          @click="openModal(card)"
      />
    </div>

    <div class="add-card">
      <input
          type="text"
          v-model="newCardTitle"
          placeholder="Add task?"
          class="add-card-input"
      />
      <button @click="addNewCard" class="add-card-button">Add</button>
    </div>
  </div>
</template>

<script lang="ts">
import {defineComponent, ref} from "vue";
import KanbanCard from "./KanbanCard.vue";

let hardCodeCounter = 5; // hardcode counter til id til topics, tager ikke account for slettede topics


export default defineComponent({
  name: "KanbanColumn",
  components: {KanbanCard},
  props: {
    id: {type: Number, required: true},
    title: {type: String, required: true},
    cards: {type: Array, required: true},
  },
  emits: ["add-card", "dragStart", "drop", "open-modal"],
  setup(props, {emit}) {
    const newCardTitle = ref("");
    // function til at lave nyt card og sende til parent komponent
    const addNewCard = () => {
      if (newCardTitle.value.trim() === "") return; // check om inputfield er tomt

      const newCard = {
        id: hardCodeCounter++,
        title: newCardTitle.value.trim(),
        description: "",
      };

      emit("add-card", {columnId: props.id, card: newCard});
      newCardTitle.value = "";
    };
    // på drag start find det valgte card id column id og send til parent
    const onDragStart = (card: any, cardIndex: number) => {
      emit("dragStart", {card, cardIndex, columnId: props.id});
    };
    // valgte drop column id sendt til parent
    const onDrop = () => {
      emit("drop", {targetColumnId: props.id});
    };
    // tillad dropping ved at prevent default dragover behaviour
    const onDragOver = (event: DragEvent) => {
      event.preventDefault();
    };
    //emit event til at åbne modal for valgte card
    const openModal = (card: any) => {
      emit("open-modal", card)
    }

    return {
      newCardTitle,
      addNewCard,
      onDragStart,
      onDrop,
      onDragOver,
      openModal,
    };
  },
});
</script>

<style>
.column {
  background: #e896a2;
  padding: 16px;
  width: 20em;
  min-height: 10em;
  max-height: 35em;
  overflow-y: auto;
  border: 3px solid transparent;
  border-radius: 8px;
  box-shadow: 0 0 0 2px #b06969;
  transition: box-shadow 0.1s ease, border-color 0.1s ease;
}

.column:hover {
  border-color: transparent;
  box-shadow: 0 0 0 3px hsl(0, 55.6%, 14.1%);
}

.columnTitle {
  color: hsl(26.7, 100%, 98.2%);
  font-size: 2em;
  letter-spacing: 1px;
}

.add-card {
  margin-top: 2em;
  display: flex;
  align-items: center;
  gap: 8px;
}

.add-card-input {
  flex-grow: 1;
  padding: 8px;
  background: white;
  border: 1px solid #ccc;
  border-radius: 4px;
}

.add-card-button {
  padding: 8px 12px;
  background-color: #3a7327;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.add-card-button:hover {
  background-color: #214216;
}
</style>
