<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Glue.WebForm1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link type="text/css" rel="stylesheet" href="bootstrap-combined.min.css" />
    <link type="text/css" rel="stylesheet" href="Theme.css" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js" type="text/javascript"></script>
    <script src="jquery.autocomplete.min.js" type="text/javascript"></script>
    <script type="text/javascript">
       $(document).ready(function () {
       $("#<%=queryip.ClientID %>").autocomplete('AutoComp.ashx');
      });
    </script>
    <style type="text/css">
            body {
        padding-top: 0px;
        padding-bottom: 40px;
        padding-top: 0px;
        padding-bottom: 0px;
		font-family: 'Roboto', sans-serif;
		
      }
	  
	  *{
	  box-sizing:border-box;
	  -webkit-box-sizing:border-box;
	  -moz-box-sizing:border-box;
	  }

	footer{
  background:none;
  color:#2b2b2b;
}

footer a{
   color:#2b2b2b;
  text-decoration:underline;
}
	
	.navbar .container  {
		max-width: 1170px;
		}

	  h1,h2,h3,h4,h5,h6{
		font-weight:200;
	  }
	  .navbar-inverse .navbar-inner{
		-webkit-border-radius: 0px;
			-moz-border-radius: 0px;
				border-radius: 0px;
				background:#282828;
				border:none;
		}
		
		.page-header{
			border:none;
			padding: 10px 0px 0px;
			margin: 0px 0 0px;
		}
		.brand{
			
			margin-left:20px;
			font-weight:700;
		}
		
		.thumbnail{
			margin-bottom:20px;
			padding:0px;
			-webkit-border-radius: 0px;
			-moz-border-radius: 0px;
			border-radius: 0px;

		}
		
	.well {
		min-height: 20px;
		padding: 19px;
		margin-bottom: 20px;
		-webkit-border-radius: 0px;
		-moz-border-radius: 0px;
		border-radius: 0px;
		-webkit-box-shadow: none;
		-moz-box-shadow: none;
		box-shadow: none;
	}
	

	.nav-tabs > li > a {

		-webkit-border-radius: 0px;
		-moz-border-radius: 0px;
		border-radius: 0px;
	}

	.carousel-inner > .item > img, 
	.carousel-inner > .item > a > img {
		min-width:100%;
	}
		  /*************** FIX Bootstrap margin-left:30px on row-fluid scafolding **************/ 
	.container-folio.row-fluid .span6:nth-child(2n+1), #container-folio.row-fluid .span6:nth-child(2n+1){
		margin-left:0px;
	}
	
	.container-folio.row-fluid .span4:nth-child(3n+1), #container-folio.row-fluid .span4:nth-child(3n+1){
		margin-left:0px;
	}	
	
	.container-folio.row-fluid .span3:nth-child(4n+1), #container-folio.row-fluid .span3:nth-child(4n+1){
		margin-left:0px;
	}
	
	.row-fluid.articles-grid .span6:nth-child(2n+1){
		margin-left:0px;
	} /* fixed bs margin when row-fluid grid*/
	
	/* FIX BOOTSTRAP pull-right margin-lefo 0px fo :first-child */
	.row-fluid [class*="span"].pull-right:first-child {
		margin-left: 30px;
	}
	.row-fluid [class*="span"].left-side:last-child {
		margin-left: 0px;
		
	}

	
	.fixed-top{
		position:fixed;
		top:0px;
		bottom:0px;
		display:inline-block;
		max-width:370px;
		background:e0e0e0;
		barder:1px solid #dfdfdf;
		z-index:1030;
	}
	
	.tab-content .tab-pane{
		max-height:600px;
		position:relative;
		overflow:auto;
	}

	footer{
		padding-top:40px;
		margin-top:40px;
		border-top:1px solid #dedede;
	}
	.related-projects{
		padding-top:40px;
		margin-top:40px;
		
	}
	
	#cat-navi select{
			display:none;
		}
	
		/*************** @media ******************/
	@media (max-width: 940px){
	.brand {
		display:block;
		text-align:center;
		font-size:26px;
		}
		#cat-navi select{
			display:block;
			width:100%;
		}
		#cat-navi li{
			display:none;
		}
}

@media (max-width: 1200px) and (min-width: 940px){
		
	
	
}

@media (max-width: 940px) and (min-width: 768px){
	.fixed-top{
		max-width:225px;
	}
	.row-fluid [class*="span"].left-side:last-child {
		clear:both;
	}
	


}
        </style>
</head>
<body>
    <form id="form1" runat="server">
    <%--<div class="navbar navbar-inverse">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class="active"><a href="http://www.bootstraptor.com">BRAND HOME</a></li>
              <li><a href="http://www.bootstraptor.com">About</a></li>
              <li><a href="http://www.bootstraptor.com">Contact</a></li>
              <li class="dropdown">
                <a href="http://www.bootstraptor.com" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="http://www.bootstraptor.com">Action</a></li>
                  <li><a href="http://www.bootstraptor.com">Another action</a></li>
                  <li><a href="http://www.bootstraptor.com">Something else here</a></li>
                  <li class="divider"></li>
                  <li class="nav-header">Nav header</li>
                  <li><a href="http://www.bootstraptor.com">Separated link</a></li>
                  <li><a href="http://www.bootstraptor.com">One more separated link</a></li>
                </ul>
              </li>
			  
            </ul>
			<div class="pull-right">
				<a class="btn btn-mini" style="margin:10px 5px 5px 10px;" href="http://www.bootstraptor.com">Sign in</a>
				<a class="btn btn-mini" style="margin:10px 10px 5px 0px;" href="http://www.bootstraptor.com">Sign up</a>
				<div class="btn-group">
					  <button class="btn btn-mini">En</button>
					  <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
						<span class="caret"></span>
					  </button>
					  <ul class="dropdown-menu" style="min-width:30px;">
						<!-- dropdown menu links -->
						<li><a href="">Ru</a></li>
						<li><a href="">Fr</a></li>
						<li><a href="">Es</a></li>
						
					  </ul>
					</div>
			</div>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>--%>



    <!-- PAGE-HEADER-->
      <div class="page-header">
		<div class="container">
			<div class="row-fluid">
                <br />
                <br />
                <br />
                <br />
				<div class="span12" style="text-align:center">
					<%--<h1 class="text-success">GLUE-QA SYSTEM</h1>--%>
                    <asp:Image ID="Image1" runat="server" Width="300px" ImageUrl="~/QA.jpeg" />
                    <asp:Image ID="Image2" runat="server" Width="100px" ImageUrl="~/QM.jpg" />
                    
				</div>
                <br />
                <br />
                <br />
                <br />
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                    <Services>

                <asp:ServiceReference Path="~/autocomp.asmx" />

            </Services>
                </asp:ScriptManager>
                <asp:HiddenField ID="val1" runat="server" />
                <asp:HiddenField ID="val2" runat="server" />
                <asp:HiddenField ID="wrong" runat="server" />
                <div style="margin-left:333px">
				    <div class="row-fluid" style="width:90%; background-color:white;">
			            <div class="well" style="background-color:white; border:hidden">
				            <div class="row-fluid" style="background-color:white;">
					            <div class="span6" style="background-color:white;">
						
			                        <asp:TextBox ID="queryip" CssClass="lead" runat="server" Width="500px" Height="30px"></asp:TextBox>
                                    <br />
                                    <div style="margin-left:50px"><asp:Label ID="didp" runat="server" Visible="false" Text="Did you mean "></asp:Label>
                                        <asp:Button ID="didb" runat="server" Visible="false" Text="Button" Font-Bold="true" Font-Underline="true" Font-Italic="true" ForeColor="Red" BackColor="White" OnClick="didb_Click" BorderStyle="None" /></div>
                                    <asp:Label ID="l1" runat="server" Text="" Font-Bold="true" Font-Size="Medium" ForeColor="Green"></asp:Label>
                                    <asp:Table ID="itab" runat="server" Visible="false"></asp:Table>
                                    <br />
                                    <asp:Label ID="morep" runat="server" Visible="false" Text="More On this " Font-Bold="true"></asp:Label>
                                        <asp:Button ID="more" runat="server" Visible="false" Text="Button" Font-Bold="true" Font-Underline="true" Font-Italic="true" ForeColor="Red" BackColor="White" OnClick="more_Click" BorderStyle="None" />
					            </div>
					            <div class="span3" style="text-align:left; margin-left:153px">
						            <div style="float:left">
                                        <asp:Button ID="Button1" CssClass="btn btn-small btn-danger btn-block" runat="server" OnClick="Button1_Click" Text="SEARCH" />
                                    </div>
					            </div>
					
				            </div>
			            </div>
		            </div>
                </div>
				</div>
			</div>
		 </div>
		<hr>	
			<%--<div class="row-fluid">
				<div class="span3">
					<div class="well text-center">
						<a href="http://www.bootstraptor.com">MAN</a> / <a href="http://www.bootstraptor.com">WOMAN</a>
					</div>
				</div>
				<div class="span3 hidden-phone">
					<div class="well text-center">
						<a href="http://www.bootstraptor.com">OFFER HERE</a>
					</div>
				</div>
				<div class="span3 hidden-phone">
					<div class="well text-center">
						<a href="http://www.bootstraptor.com">OFFER HERE</a>
					</div>
				</div>
				<div class="span3 hidden-phone">
					<div class="well text-center">
						<a href="http://www.bootstraptor.com">OFFER HERE</a>
					</div>
				</div>
			</div>--%>
     
<!-- PAGE-HEADER-->


<!-- MAIN CONTAINER-->
<div class="container">
	<div class="row-fluid">
	<!-- LEFT SIDE CATEGORIES-->   
	<div class="span3" style="visibility:hidden">         
		<div class="well" visible="false">
			<ul id="cat-navi" class="nav nav-list">
			  <li class="nav-header">Shop by Product</li>
			  <li class="active"><a href="http://www.bootstraptor.com">Active category</a></li>
			  <li><a href="http://www.bootstraptor.com">New in: Category</a></li>
			  <li><a href="http://www.bootstraptor.com">New in: Category</a></li>
			  <li><a href="http://www.bootstraptor.com">New in: Category</a></li>
			  <li><a href="http://www.bootstraptor.com">New in: Category</a></li>
			  <li><a href="http://www.bootstraptor.com">New in: Category</a></li>
			</ul>
			
			<hr>
			
			<ul id="cat-navi2" class="nav nav-list hidden-phone">
			  <li class="nav-header">MOST POPURAL</li>
			  <li class="active"><a href="http://www.bootstraptor.com">Active category</a></li>
			  <li><a href="http://www.bootstraptor.com">Category title</a></li>
			  <li><a href="http://www.bootstraptor.com">Category title</a></li>
			  <li><a href="http://www.bootstraptor.com">Category title</a></li>
			  <li><a href="http://www.bootstraptor.com">Category title</a></li>
			  <li><a href="http://www.bootstraptor.com">Category title</a></li>
			  <li><a href="http://www.bootstraptor.com">Category title</a></li>
			  <li><a href="http://www.bootstraptor.com">Category title</a></li>
			  <li><a href="http://www.bootstraptor.com">Category title</a></li>
			  <li><a href="http://www.bootstraptor.com">Category title</a></li>
			  <li><a href="http://www.bootstraptor.com">Category title</a></li>
			</ul>
			
			
		</div><!-- /well--> 
			
			<!-- WELL OFFER-->
			<div class="well">
				<p class="lead">
					Bootstrap 3.0. themes on <a href="http://www.bootstraptor.com/themes">www.bootstraptor.com</a>
				</p>
			</div>
			<!-- / WELL OFFER-->
			
			<!-- WELL OFFER-->
			<div class="well hidden-phone">
				<p class="lead">
					Bootstrap 3.0. HTML templates on <a href="http://www.bootstraptor.com">www.bootstraptor.com</a>
				</p>
			</div>
			<!-- / WELL OFFER-->
			
			<!-- WELL OFFER-->
			<div class="well hidden-phone">
				<p class="lead">
                  Bootstrap 3.0. themes on <a href="http://www.bootstraptor.com/themes">www.bootstraptor.com</a>
				</p>
			</div>
			<!-- / WELL OFFER-->
			
			<!-- WELL OFFER-->
			<div class="well hidden-phone">
				<p class="lead">
					Bootstrap 3.0. HTML templates on <a href="http://www.bootstraptor.com">www.bootstraptor.com</a>
				</p>
			</div>
			<!-- / WELL OFFER-->
			
	</div>
	<!-- /left SIDE--> 
	
		<!-- CONTENT SIDE-->
	<div class="span9">
		
		<!-- SLIDER -->
		<%--<div class="row-fluid">
			<div id="myCarousel" class="carousel slide">
                <ol class="carousel-indicators">
                  <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                  <li data-target="#myCarousel" data-slide-to="1" class=""></li>
                  <li data-target="#myCarousel" data-slide-to="2" class=""></li>
                </ol>
                <div class="carousel-inner">
                  <div class="item active">
                    <img src="http://lorempixel.com/770/400/technics/1/" alt="post image">
                    <div class="carousel-caption">
                      <h4>First Thumbnail label</h4>
                      <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                    </div>
                  </div>
                  <div class="item">
                     <img src="http://lorempixel.com/770/400/technics/1/" alt="post image">
                    <div class="carousel-caption">
                      <h4>Second Thumbnail label</h4>
                      <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                    </div>
                  </div>
                  <div class="item">
                     <img src="http://lorempixel.com/770/400/technics/1/" alt="post image">
                    <div class="carousel-caption">
                      <h4>Third Thumbnail label</h4>
                      <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                    </div>
                  </div>
                </div>
                <a class="left carousel-control" href="#myCarousel" data-slide="prev">‹</a>
                <a class="right carousel-control" href="#myCarousel" data-slide="next">›</a>
              </div>
		</div>--%>
		<!-- / SLIDER -->
		
		<!-- MARKETING LINE-->
		<%--<div class="row-fluid">
			<div class="well">
				<div class="row-fluid">
					<div class="span8">
						<p class="lead">
			
                          Get this full ecommerce template built with Bootstrap 3.0. ! 
						</p>
					</div>
					<div class="span4">
						<a class="btn btn-large btn-danger btn-block" href="https://creativemarket.com/artlabs/11085-Ecommerce-responsive-BS3.0.v" target="_blank"> GET TEMPLATE →</a>

					</div>
					
				</div>
			</div>
		</div>--%>
		<!-- /MARKETING LINE-->
		
		<!-- FEATURED PRODUCTS -->
<%--<div class="row-fluid articles-grid">
 <!-- ITEM -->
 <div class="span6">
	<div class="thumbnail">
        <!-- IMAGE CONTAINER-->
        <img src="http://lorempixel.com/400/200/technics/1/" alt="post image">
		<!--END IMAGE CONTAINER-->
		<!-- CAPTION -->
		<div class="caption">
			<h3 class="">Featured product title</h3>
			<p class="">This project presents beautiful style graphic &amp; design. Bootstraptor provides modern features</p>
			<p>
			<a class="" href="http://www.bootstraptor.com" title="">Read more →</a>
			</p>
		</div> 
		<!--END CAPTION -->
	</div>
<!-- END: THUMBNAIL -->
</div>
<!-- END ITEM -->

<!-- ITEM -->
 <div class="span6">
	<div class="thumbnail">
        <!-- IMAGE CONTAINER-->
        <img src="http://lorempixel.com/400/200/technics/1/" alt="post image">
		<!--END IMAGE CONTAINER-->
		<!-- CAPTION -->
		<div class="caption">
			<h3 class="">Featured product title</h3>
			<p class="">This project presents beautiful style graphic &amp; design. Bootstraptor provides modern features</p>
			<p>
			<a class="" href="http://www.bootstraptor.com" title="">Read more →</a>
			</p>
		</div> 
		<!--END CAPTION -->
	</div>
<!-- END: THUMBNAIL -->
</div>
<!-- END ITEM -->

</div>--%>
<!-- / FEATURED PRODUCTS -->

<!-- MARKETING LINE-->
		
		<!-- /MARKETING LINE-->
		

		<!-- MAIN PRODUCTS GRID-->
	<%--<div class="row-fluid container-folio">
			
				<!-- PROD GRID 
				============================================================ -->
				
				<!-- PROD. ITEM -->
				<div class="span4">
					<div class="thumbnail">
						<!-- IMAGE CONTAINER-->
						<img src="http://lorempixel.com/400/200/technics/1/" alt="post image">
						<!--END IMAGE CONTAINER-->
						<!-- CAPTION -->
						<div class="caption">
						<h3 class="">Product title</h3>
							<p class="">This project presents beautiful style graphic &amp; design. Bootstraptor provides modern features</p>
							
							<div class="row-fluid">
								<div class="span6">
									<p class="lead">$21.000</p>
								</div>
								<div class="span6">
									<a class="btn btn-success btn-block" href="http://www.bootstraptor.com">Add to cart</a>
								</div>
							</div>
						</div> 
						<!--END CAPTION -->
					</div>
					<!-- END: THUMBNAIL -->
				</div>
				<!-- PROD. ITEM -->
				
				<!-- PROD. ITEM -->
				<div class="span4">
					<div class="thumbnail">
						<!-- IMAGE CONTAINER-->
						<img src="http://lorempixel.com/400/200/technics/1/" alt="post image">
						<!--END IMAGE CONTAINER-->
						<!-- CAPTION -->
						<div class="caption">
						<h3 class="">Product title</h3>
							<p class="">This project presents beautiful style graphic &amp; design. Bootstraptor provides modern features</p>
							
							<div class="row-fluid">
								<div class="span6">
									<p class="lead">$21.000</p>
								</div>
								<div class="span6">
									<a class="btn btn-success btn-block" href="http://www.bootstraptor.com">Add to cart</a>
								</div>
							</div>
						</div> 
						<!--END CAPTION -->
					</div>
					<!-- END: THUMBNAIL -->
				</div>
				<!-- PROD. ITEM -->
				
				<!-- PROD. ITEM -->
				<div class="span4">
					<div class="thumbnail">
						<!-- IMAGE CONTAINER-->
						<img src="http://lorempixel.com/400/200/technics/1/" alt="post image">
						<!--END IMAGE CONTAINER-->
						<!-- CAPTION -->
						<div class="caption">
						<h3 class="">Product title</h3>
							<p class="">This project presents beautiful style graphic &amp; design. Bootstraptor provides modern features</p>
							
							<div class="row-fluid">
								<div class="span6">
									<p class="lead">$21.000</p>
								</div>
								<div class="span6">
									<a class="btn btn-success btn-block" href="http://www.bootstraptor.com">Add to cart</a>
								</div>
							</div>
						</div> 
						<!--END CAPTION -->
					</div>
					<!-- END: THUMBNAIL -->
				</div>
				<!-- PROD. ITEM -->	
				
				<!-- PROD. ITEM -->
				<div class="span4">
					<div class="thumbnail">
						<!-- IMAGE CONTAINER-->
						<img src="http://lorempixel.com/400/200/technics/1/" alt="post image">
						<!--END IMAGE CONTAINER-->
						<!-- CAPTION -->
						<div class="caption">
						<h3 class="">Product title</h3>
							<p class="">This project presents beautiful style graphic &amp; design. Bootstraptor provides modern features</p>
							
							<div class="row-fluid">
								<div class="span6">
									<p class="lead">$21.000</p>
								</div>
								<div class="span6">
									<a class="btn btn-success btn-block" href="http://www.bootstraptor.com">Add to cart</a>
								</div>
							</div>
						</div> 
						<!--END CAPTION -->
					</div>
					<!-- END: THUMBNAIL -->
				</div>
				<!-- PROD. ITEM -->

				<!-- PROD. ITEM -->
				<div class="span4">
					<div class="thumbnail">
						<!-- IMAGE CONTAINER-->
						<img src="http://lorempixel.com/400/200/technics/1/" alt="post image">
						<!--END IMAGE CONTAINER-->
						<!-- CAPTION -->
						<div class="caption">
						<h3 class="">Product title</h3>
							<p class="">This project presents beautiful style graphic &amp; design. Bootstraptor provides modern features</p>
							
							<div class="row-fluid">
								<div class="span6">
									<p class="lead">$21.000</p>
								</div>
								<div class="span6">
									<a class="btn btn-success btn-block" href="http://www.bootstraptor.com">Add to cart</a>
								</div>
							</div>
						</div> 
						<!--END CAPTION -->
					</div>
					<!-- END: THUMBNAIL -->
				</div>
				<!-- PROD. ITEM -->	
				
				<!-- PROD. ITEM -->
				<div class="span4">
					<div class="thumbnail">
						<!-- IMAGE CONTAINER-->
						<img src="http://lorempixel.com/400/200/technics/1/" alt="post image">
						<!--END IMAGE CONTAINER-->
						<!-- CAPTION -->
						<div class="caption">
						<h3 class="">Product title</h3>
							<p class="">This project presents beautiful style graphic &amp; design. Bootstraptor provides modern features</p>
							
							<div class="row-fluid">
								<div class="span6">
									<p class="lead">$21.000</p>
								</div>
								<div class="span6">
									<a class="btn btn-success btn-block" href="http://www.bootstraptor.com">Add to cart</a>
								</div>
							</div>
						</div> 
						<!--END CAPTION -->
					</div>
					<!-- END: THUMBNAIL -->
				</div>
				<!-- PROD. ITEM -->
				
				<!-- / PROD GRID 
				======================================= -->
				
				
				
	</div>--%>
<!-- /INNER ROW-FLUID-->
			
<!-- PAGINATION-->
<%--<div class="pagination pull-right">
  <ul>
    <li><a href="http://www.bootstraptor.com">Prev</a></li>
    <li><a href="http://www.bootstraptor.com">1</a></li>
    <li><a href="http://www.bootstraptor.com">2</a></li>
    <li><a href="http://www.bootstraptor.com">3</a></li>
    <li><a href="http://www.bootstraptor.com">4</a></li>
    <li><a href="http://www.bootstraptor.com">5</a></li>
    <li><a href="http://www.bootstraptor.com">Next</a></li>
  </ul>
</div>--%>
<!-- /PAGINATION-->
</div>
<!-- /CONTENT SIDE-->
	
</div>


<!-- FOOTER-->
<%--<footer class="row-fluid">
      <div class="span3">
        <h4 class="line3 center standart-h4title"><span>Navigation</span></h4>
        <ul class="footer-links">
          <li><a href="http://www.bootstraptor.com">Home</a></li>
          <li><a href="http://www.bootstraptor.com">project</a></li>
          <li><a href="http://www.bootstraptor.com">Elements</a></li>
          <li><a href="http://www.bootstraptor.com">Contact</a></li>
          <li><a href="http://www.bootstraptor.com">Blog</a></li>
        </ul>
      </div>
	  
    <div class="span3">
        <h4 class="line3 center standart-h4title"><span>Useful Links</span></h4>
        <ul class="footer-links">
          <li><a href="http://www.bootstraptor.com">Bootstraptor.com</a></li>
          <li><a href="http://www.bootstraptor.com">Bootstraptor.com</a></li>
         <li><a href="http://www.bootstraptor.com">Bootstraptor.com</a></li>
         <li><a href="http://www.bootstraptor.com">Bootstraptor.com</a></li>
         <li><a href="http://www.bootstraptor.com">Bootstrap templates</a></li>
        </ul>
    </div> 
	  
	<div class="span3">
        <h4 class="line3 center standart-h4title"><span>Useful Links</span></h4>
        <ul class="footer-links">
          <li><a href="http://www.bootstraptor.com">Bootstraptor.com</a></li>
          <li><a href="http://www.bootstraptor.com">Bootstraptor.com</a></li>
		<li><a href="http://www.bootstraptor.com">Bootstraptor.com</a></li>
         <li><a href="http://www.bootstraptor.com">Bootstraptor.com</a></li>
         <li><a href="http://www.bootstraptor.com">Bootstrap templates</a></li>
        </ul>
    </div>
	
    <div class="span3">
        <h4 class="line3 center standart-h4title"><span>Our office</span></h4>
		<address>
			<strong>bootstraptor.com, LLC.</strong><br>
			<i class="fa-icon-map-marker"></i> 795 Folsom Ave, Suite 600<br>
			San Francisco, CA 94107<br>
			<i class="fa-icon-phone-sign"></i> + 4 (123) 456-7890
		
		</address>
    </div>
  
<div class="span12">
	<hr>
        <p>© bootstraptor.com Company 2013</p>
</div>
	  
</footer>--%>
<!-- /Footer-->

 
</div> <!-- /container -->
<!--/ CONTENT -->
    </form>
</body>
</html>
