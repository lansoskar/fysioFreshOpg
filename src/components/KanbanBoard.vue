<template>
  <div class="board">
    <KanbanColumn
        v-for="column in KanbanColumns"
        :key="column.id"
        :id="column.id"
        :title="column.title"
        :cards="column.cards"
        @dragStart="onDragStart"
        @drop="onDrop"
        @add-card="addCard"
        @open-modal="openCardModal"
    />
    <div v-if="modalVisible" class="modal-overlay" @click.self="closeModal">
      <div class="modal">
        <div class="modal-header">
          <h2>{{ selectedCard?.title }}</h2>
          <h2 class="modal-task-number">Task#{{ selectedCard?.id }}</h2>
        </div>
        <textarea
            v-model="selectedCard.description"
            class="description-input"
            placeholder="Beskriv Task?"
        ></textarea>
        <div class="modal-actions">
          <button @click="deleteCard" class="delete-button">Delete Task</button>
          <button @click="closeModal" class="close-button">Close</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import {defineComponent, reactive, ref} from "vue";
import KanbanColumn from "./KanbanColumn.vue";

export default defineComponent({
  name: "KanbanBoard",
  components: {KanbanColumn},
  emits: [],
  setup() {
    const KanbanColumns = reactive([
      {
        title: "Backlog",
        id: 1,
        cards: [{id: 1, title: "testing", description: "lav unit tests"}],
      },
      {title: "To Do", id: 2, cards: [{id: 2, title: "prøv at incorporate vuetify"}]},
      {title: "In Progress", id: 3, cards: [{id: 3, title: "simpel ui"}]},
      {title: "Done", id: 4, cards: [{id: 4, title: "lav alt funktionalitet"}]},
    ]);
    const draggedCard = ref<null | { card: any; cardIndex: number; columnId: number }>(null);
    const modalVisible = ref(false);
    const selectedCard = ref<any>(null);


    // tilføj card til specified column, med dens column card array
    const addCard = ({columnId, card}: { columnId: number; card: any }) => {
      const column = KanbanColumns.find((col) => col.id === columnId);
      if (column) column.cards.push(card);
    };
    // dragstart valgte card data bliver payload
    const onDragStart = (payload: { card: any; cardIndex: number; columnId: number }) => {
      draggedCard.value = payload;
    };

    //on card drop på valgte column splice fra original kolumn og push til valgte
    const onDrop = ({targetColumnId}: { targetColumnId: number }) => {
      // hvis ikke noget valgt card return
      if (!draggedCard.value) return;
      // find source og target columns
      const {card, cardIndex, columnId} = draggedCard.value;
      const sourceColumn = KanbanColumns.find((col) => col.id === columnId);
      const targetColumn = KanbanColumns.find((col) => col.id === targetColumnId);

      if (sourceColumn && targetColumn) {
        sourceColumn.cards.splice(cardIndex, 1);
        targetColumn.cards.push(card);
      }
      // reset payload
      draggedCard.value = null;
    };
    // åben modal med valgte card data til display
    const openCardModal = (card: any) => {
      selectedCard.value = card;
      modalVisible.value = true;
    }
    // lukker modal
    const closeModal = () => {
      modalVisible.value = false;

    }
    // sletter card baseret på column, laver et nyt array ved at filtrere valgte card ud
    const deleteCard = () => {
      const column = KanbanColumns.find((col) =>
          col.cards.includes(selectedCard.value)
      );
      if (column) {
        column.cards = column.cards.filter((card) => card !== selectedCard.value);
        closeModal();
      }
    };

    return {
      KanbanColumns,
      draggedCard,
      modalVisible,
      selectedCard,
      addCard,
      onDragStart,
      onDrop,
      openCardModal,
      closeModal,
      deleteCard,
    };
  },
});
</script>

<style>
.board {
  display: flex;
  flex-direction: row;
  align-items: flex-start;
  gap: 16px;
  max-height: 80%;
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
}

.modal {
  background: white;
  padding: 20px;
  border-radius: 8px;
  border: 2px solid hsl(0, 55.6%, 14.1%);
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
  max-width: 40em;
  width: 100%;
}

.description-input {
  font-family: Roboto;
  padding: 15px;
  background-color: #d9d8d8;
  border-radius: 10px;
  width: 100%;
  height: 15em;
  margin-top: 10px;
  margin-bottom: 0.5em;
  resize: none;
}

.modal-header {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}

.modal-actions {
  display: flex;
  justify-content: space-between;
  margin-top: 20px;
}

.modal-task-number {
  opacity: 65%;
  font-family: Roboto;
}

.delete-button {
  background: red;
  color: white;
  padding: 8px 12px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.delete-button:hover {
  background: darkred;
}

.close-button {
  background: gray;
  color: white;
  padding: 8px 12px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.close-button:hover {
  background: #4b4b4b;
}
</style>
