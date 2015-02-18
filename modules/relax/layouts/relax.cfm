<cfoutput>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
<!--<![endif]-->

<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>ColdBox Relax - RESTful Tools For Lazy Experts</title>
    <!--- favicon --->
    <link href="#prc.root#/includes/images/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <!--- SES --->
	<base href="#getSetting( 'htmlBaseURL' )#" />
	<!--- View Port --->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="#prc.root#/includes/plugins/bootstrap/css/bootstrap.min.css">
    <!-- Fonts from Font Awsome -->
    <link rel="stylesheet" href="#prc.root#/includes/css/font-awesome.min.css">
    <!-- CSS Animate -->
    <link rel="stylesheet" href="#prc.root#/includes/css/animate.css">
    <!-- Custom styles for this theme -->
    <link rel="stylesheet" href="#prc.root#/includes/css/main.css">
    <!-- iCheck-->
    <link rel="stylesheet" href="#prc.root#/includes/plugins/icheck/css/_all.css">
    <!--- CUSTOM CSS --->
	<cfloop list="#event.getPrivateValue("cssAppendList","")#" index="css">
		<cfset addAsset("#prc.root#/includes/css/#css#.css")>
	</cfloop>
	<cfloop list="#event.getPrivateValue("cssFullAppendList","")#" index="css">
		<cfset addAsset("#css#.css")>
	</cfloop>

    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,900,300italic,400italic,600italic,700italic,900italic' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
    <!-- Feature detection -->
    <script src="#prc.root#/includes/js/modernizr-2.6.2.min.js"></script>
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="#prc.root#/includes/js/html5shiv.js"></script>
    <script src="#prc.root#/includes/js/respond.min.js"></script>
    <![endif]-->

</head>

<body class="animated fadeIn">
	<section id="container">
		<header id="header">
            <!--logo start-->
            <div class="brand">
                <a href="#event.buildLink( prc.xehHome )#" class="logo"><span>Relax</span></a>
            </div>
            <!--Toggle-->
            <div class="toggle-navigation toggle-left">
                <button type="button" class="btn btn-default" id="toggle-left" data-toggle="tooltip" data-placement="right" title="Toggle Navigation">
                    <i class="fa fa-bars"></i>
                </button>
            </div>
            <!-- NavBar -->
            <div class="user-nav">
                <ul>
                	<li>
                  		<button type="button" class="btn btn-default dropdown-toggle options" id="toggle-mail" data-toggle="dropdown">
                        	<i class="fa fa-gamepad"></i>
                    	</button>
                    </li>
                    <li class="dropdown settings">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="##">
                      		RESTFul Tools For Lazy Experts<i class="fa fa-angle-down"></i>
                    	</a>
                        <ul class="dropdown-menu animated fadeInDown">
                            
                        	<li>
                        		<a href="http://www.ortussolutions.com" title="The experts behind ColdBox"><i class="fa fa-bolt"></i> By Ortus Solutions</a>
                        	</li>
							<li>
								<a href="http://www.coldbox.org" title="The premier ColdFusion development platform"><i class="fa fa-link"></i> Powered By ColdBox</a>
							</li>
							<li>
								<a href="http://www.github.com/coldbox/coldbox-relax" title="The Relax Source Code"><i class="fa fa-github"></i> Github Repo</a>
							</li>
							<li>
								<a href="http://www.twitter.com/coldbox" title="Follow me!"><i class="fa fa-twitter"></i> Tweet</a>
							</li>
                        </ul>
                    </li>
                </ul>
            </div>
        </header>
	</section>

	<!--sidebar start-->
    <aside class="sidebar">
        <div id="leftside-navigation" class="nano">
            <ul class="nano-content">
                <li <cfif event.getCurrentHandler() eq "relax:home">class="active"</cfif>>
                    <a href="#event.buildLink( prc.xehHome )#"><i class="fa fa-dashboard"></i><span>API Manager</span></a>
                </li>
                <li <cfif event.getCurrentHandler() eq "relax:relaxer">class="active"</cfif>>
                    <a href="#event.buildLink( prc.xehRelaxer )#" title="Pronounced 'Relax-ER'"><i class="fa fa-flask"></i><span>RelaxURL</span></a>
                </li>
                <li <cfif event.getCurrentAction() eq "DSLDocs">class="active"</cfif>>
                    <a href="#event.buildLink( prc.xehDSLDocs )#" ><i class="fa fa-code"></i><span>RelaxDSL Docs</span></a>
                </li>
            </ul>
        </div>
    </aside>
    <!--sidebar end-->
	
	<!--========= JAVASCRIPT -->
	<script src="#prc.root#/includes/js/jquery.min.js"></script> <!--Import jquery tools-->
    <script src="#prc.root#/includes/plugins/bootstrap/js/bootstrap.min.js"></script>
	<script src="#prc.root#/includes/js/jsonlint.js"></script>
	<script src="#prc.root#/includes/js/relax.js"></script>

	<!--- loop around the jsAppendList, to add page specific js --->
	<cfloop list="#event.getPrivateValue("jsAppendList", "")#" index="js">
		<cfset addAsset("#prc.root#/includes/js/#js#.js")>
	</cfloop>
	<cfloop list="#event.getPrivateValue("jsFullAppendList", "")#" index="js">
		<cfset addAsset("#js#.js")>
	</cfloop>

	<!-- syntax highlighter -->
	<link type="text/css" rel="stylesheet" href="#prc.root#/includes/highlighter/styles/shCoreMidnight.css">
	<script src="#prc.root#/includes/highlighter/scripts/shCore.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushColdFusion.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushXml.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushSql.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushJScript.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushJava.js"></script>
	<script src="#prc.root#/includes/highlighter/scripts/shBrushCss.js"></script>
	<script>
	$(document).ready(function() {
		// syntax highlight
		SyntaxHighlighter.all();
	});
	</script>

	<!--main content start-->
    <section class="main-content-wrapper">
        <section id="main-content">
           #renderView()#         
        </section>
    </section>
    <!--main content end-->
</section>


<!--- ============================ Remote Modal Window ============================ --->
<div id="remoteModal">
	<div id="remoteModelContent">
	</div>
</div>
<!--- ============================ end Confirmit ============================ --->

</body>
<!--End Body-->
</html>
</cfoutput>