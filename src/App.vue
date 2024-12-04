<!--html og dom elementer-->
<template>
  <header class="center"><p class="headerText">Kanban board opgave fra FysioFresh🌻</p></header>
  <div class="margins">
    <KanbanBoard/>
  </div>

</template>

<!--data manipulation og funktioner-->
<script lang="ts">
import { defineComponent } from 'vue';
import KanbanBoard from "./components/KanbanBoard.vue";

export default defineComponent({
  name: 'App',
  components: {
    KanbanBoard,
  }
});
</script>

<!--css for komponent-->
<style>
.center {
  padding: 4px;
  background: hsl(0, 55.6%, 14.1%);
  margin-bottom: 1.5em;
}

.headerText {
  color: hsl(26.7, 100%, 98.2%);
  letter-spacing: 1px;
  font-size: 1.5em;

  margin-left: 0.5em;
}

.margins {
  display: flex;
  max-width: 85%;
  margin-left: 3em;
}
</style>
