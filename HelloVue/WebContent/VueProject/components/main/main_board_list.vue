<template>
<div class="col-lg-6" style="margin-top:20px">
	<div class="card shadow">
		<div class="card-body">
			<h4 class="card-title">자유게시판</h4>
			<table class="table table-hover" id='board_list'>
				<thead>
					<tr>
						<th class="text-center w-25">글번호</th>
						<th>제목</th>
						<th class="text-center w-25 d-none d-xl-table-cell">작성날짜</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for='a1 in temp_list' @click="go_board_read">
						<td class="text-center">{{a1}}</td>
						<td>ㅎㅇ</td>
						<td class="text-center d-none d-xl-table-cell"></td>
					</tr>
				</tbody>
			</table>
			
			<router-link to="/board_main" class="btn btn-primary">더보기</router>
		</div>
	</div>
</div>
</template>
<style>
	#board_list > tbody > tr {
		cursor: pointer;
	}
</style>
<script>
	module.exports = {
		data:function(){
			return {
				temp_list : [1,2,3,4,5]
			}
		},
		methods:{
			go_board_read:function(){
				this.$router.push("/board_read")
			}
		}
	}
</script>