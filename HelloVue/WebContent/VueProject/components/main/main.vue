<template>
<div class="container" style="margin-top:100px">
	<div class="row">
		<main-board-list></main-board-list>
		<main-board-list></main-board-list>
		<main-board-list></main-board-list>
		<main-board-list></main-board-list>
	</div>
</div>
</template>
<script>
	module.exports = {
		components :{
			'main-board-list' : httpVueLoader("components/main/main_board_list.vue")
		}
	}
</script>