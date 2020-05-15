var store = new Vuex.Store({
	state : {
		user_login_chk : false,
		user_id : '',
		user_name : '',
		user_idx : 0
	}
})

var router = new VueRouter({
	routes:[
		{
			path:"/",
			component:httpVueLoader("components/main/main.vue")
		},
		{
			path:"/board_main/:board_idx/:page",
			component:httpVueLoader("components/board/board_main.vue")
		},
		{
			path:"/login",
			component:httpVueLoader("components/user/login.vue")
		},
		{
			path:"/join",
			component:httpVueLoader("components/user/join.vue")
		},
		{
			path:"/user_modify",
			component:httpVueLoader("components/user/user_modify.vue")
		},
		{
			path:"/board_read/:board_idx/:page/:content_idx",
			component:httpVueLoader("components/board/board_read.vue")
		},
		{
			path:"/board_modify/:board_idx/:page/:content_idx",
			component:httpVueLoader("components/board/board_modify.vue")
		},
		{
			path:"/board_delete/:board_idx/:page/:content_idx",
			beforeEnter(to,from,next){
				var params = new URLSearchParams()
				params.append("content_idx",to.params.content_idx)
				
				axios.post("server/board/delete_content.jsp",params).then((response)=>{
					alert("삭제되었습니다")
					next("/board_main/"+to.params.board_idx+'/'+to.params.page)
				})
				
			}
		},
		{
			path:"/board_write/:board_idx/:page",
			component:httpVueLoader("components/board/board_write.vue")
		},
		{
			path:"/logout",
			beforeEnter(to,from,next){
				alert("로그아웃 되었습니다.")
				store.state.user_login_chk=false
				store.state.user_id = ''
				store.state.user_name = ''
				store.state.user_idx = 0
				sessionStorage.clear()
				
				next("/")
			}
		}
	],
	scrollBehavior(to, from, savePosition){
		return {
			x : 0,
			y : 0
		}
	}
})