<%@page import="market.ShopDTO"%>
<%@page import="market.ShopDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
//idx값 받아오기
int idx = Integer.parseInt(request.getParameter("idx"));
// int count = Integer.parseInt(request.getParameter("count"));
ShopDAO dao = new ShopDAO();
//상품뷰 불러오기
ShopDTO dto = dao.shopView(idx);
%>
<script>
	function checkCount(count) {
		if(count.value<=0){
			alert("1개 이상의 수량만 입력하세요");
			count.value = 1;
			count.focus();
		}
	}
	var f = document.form;
</script>

<!--  <body> -->
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/market/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/market_leftmenu.jsp" %>
			</div>
			<div class="right_contents">

				<div class="top_title">
					<img src="../images/market/sub01_title.gif" alt="수아밀 제품 주문" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;수아밀 제품 주문<p>
				</div>
				<div class="market_view_box">
					<div class="market_left">
						<img src="../images/market/p_img.jpg" />
						<p class="plus_btn"><a href=""><img src="../images/market/plus_btn.gif" /></a></p>
					</div>
					<div class="market_right">
					<form action="" name="form" method="post">
						<p class="m_title"><%=dto.getProduct_name() %>
						<p>- <%=dto.getProduct_name() %></p>
						<ul class="m_list">
							<li>
								<dl>
									<dt>가격</dt>
									<dd class="p_style"><%=dto.getPrice() %></dd>
								</dl>
								<dl>
									<dt>적립금</dt>
									<dd><%=dto.getSaved_money() %></dd>
								</dl>
								<dl>
									<dt>수량</dt>
									<dd><input type="number" name="count" value="1" class="n_box" onclick="checkCount(this);"/></dd>
								</dl>
								<dl style="border-bottom:0px;">
									<dt>주문정보</dt>
									<dd><input type="text" name="" class="n_box" style="width:200px;" /></dd>
								</dl>
								<div style="clear:both;"></div>
							</li>
						</ul>
						<p class="btn_box">
						<!-- javascript: form.action 속성을 이용한 submit -->
						<button type="submit" onclick="javascript: form.action='basket02.jsp';">
							<img src="../images/market/m_btn01.gif" alt="바로구매" />
						</button>
						&nbsp;&nbsp;
						<!-- formaction 속성 이용해서 한번에 url입력하기 -->
						<button type="submit" formaction="./basket.jsp">
							<img src="../images/market/m_btn02.gif" alt="장바구니" />
						</button>
					</form>
					</div>
				</div>
				<img src="../images/market/cake_img.JPG" />

			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
