<template>
<div class="container" style="margin-top:100px">
	<div class="card shadow">
		<div class="card-body">
			<h4 class="card-title">{{server_data.board_info_name}}</h4>
			<table class="table table-hover" id='board_list'>
				<thead>
					<tr>
						<th class="text-center d-none d-md-table-cell">글번호</th>
						<th class="w-50">제목</th>
						<th class="text-center d-none d-md-table-cell">작성자</th>
						<th class="text-center d-none d-md-table-cell">작성날짜</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for='obj in server_data.board_list'>
						<td class="text-center d-none d-md-table-cell">{{obj.content_idx}}</td>
						<td @click="go_board_read(obj.content_idx)">{{obj.content_subject}}</td>
						<td class="text-center d-none d-md-table-cell">{{obj.content_writer_name}}</td>
						<td class="text-center d-none d-md-table-cell">{{obj.content_date}}</td>
					</tr>
					
				</tbody>
			</table>
			
			<div class="d-none d-md-block">
				<ul class="pagination justify-content-center">
					<li class="page-item">
						<router-link :to="'/board_main/'+$route.params.board_idx+'/'+server_data.pre" class="page-link">이전</a>
					</li>
					<li class="page-item" v-for='a1 in server_data.page_array'>
						<router-link :to="'/board_main/'+$route.params.board_idx+'/'+a1" class="page-link">{{a1}}</router-link>
					</li>
					<li class="page-item">
						<router-link :to="'/board_main/'+$route.params.board_idx+'/'+server_data.next" class="page-link">다음</router-link>
					</li>
				</ul>
			</div>
			
			<div class="d-block d-md-none">
				<ul class="pagination justify-content-center">
					<li class="page-item">
						<router-link to="/board_main" class="page-link">이전</router-link>
					</li>
					<li class="page-item">
						<router-link to="/board_main" class="page-link">다음</router-link>
					</li>
				</ul>
			</div>
			
			<div class="text-right" v-if='$store.state.user_login_chk == true'>
				<router-link :to="'/board_write/' + $route.params.board_idx+'/'+$route.params.page" class="btn btn-primary">글쓰기</router>
			</div>
			
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
	module.exports={
		data:function(){
			return {
				temp_list : [1,2,3,4,5,6,7,8,9,10],
				server_data : {}
			}
		},
		methods:{
			go_board_read:function(content_idx){
				this.$router.push("/board_read/"+this.$route.params.board_idx+'/'+this.$route.params.page+'/'+content_idx)
			},
			get_board_data : function(){
				var params = new URLSearchParams()
				params.append('board_idx',this.$route.params.board_idx)
				params.append('page',this.$route.params.page)
				
				axios.post('server/board/get_board_list.jsp',params).then((response)=>{
					this.server_data = response.data
				})
			}
		},
		watch : {
			'$route' (to, from){
				this.get_board_data()
			}
		},
		created(){
			this.get_board_data()
		}
	}
</script>