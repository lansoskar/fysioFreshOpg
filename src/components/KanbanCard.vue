<template>
  <div class="card" draggable="true" @dragstart="onDragStart">
   <v-card-title class="card-header">
    <p class="card-title">{{ card.title }}</p>
    <p class="card-id">#{{ card.id }}</p>
  </v-card-title>
    <v-card-text class="description-overflow">{{ card.description }}</v-card-text>
  </div>
</template>

<script lang="ts">
import {defineComponent, PropType} from "vue";

interface CardData {
  id: number;
  title: string;
  description: string;
}

export default defineComponent({
  name: "KanbanCard",
  props: {
    card: { type: Object as PropType<CardData>, required: true },
    index: { type: Number, required: true },
    columnIndex: { type: Number, required: true },
  },
  emits: ["dragStart"],
  setup(props, { emit }) {
    // funktion til dragstart tage data af valgte card og sende videre
    const onDragStart = (event: DragEvent) => {
      event.dataTransfer?.setData("cardIndex", props.index.toString());
      event.dataTransfer?.setData("columnIndex", props.columnIndex.toString());


      emit("dragStart", {
        card: props.card,
        cardIndex: props.index,
        columnId: props.columnIndex,
      });
    };

    return { onDragStart };
  },
});
</script>

<style>
.card {
  background: #fff;
  padding: 12px;
  margin: 8px 0;
  border: 2px solid #fff;
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.5);
  transition: border-color 0.1s ease;
  user-select: none;
  cursor: pointer;
}

.card-header {
  display: flex;
  flex-direction: row;
  justify-content: space-between;

}

.description-overflow {
  display: -webkit-box;
  -webkit-line-clamp: 2; /* 2 linjer description ind i overflow til ...*/
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  max-width: 15em;
}

.card-title {
  font-weight: bold;
}

.card-id {
  opacity: 50%;
}

.card:hover {
  border-color: hsl(0, 55.6%, 14.1%)
}
</style>
