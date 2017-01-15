<%
/*
   This is the sample Checkout Page JSP script. It can be directly used for integration with CCAvenue if your application is developed in JSP. You need to simply change the variables to match your variables as well as insert routines (if any) for handling a successful or unsuccessful transaction.
*/
%>
<%@ page import = "java.io.*,java.util.*,com.ccavenue.security.*" %>
<html>
<head>
	<title>Sub-merchant checkout page</title>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
</head>
<body>
	<%
	 String merchantId = request.getParameter("121148");   
	 String accessCode = "AVBZ68EA76BA61ZBAB";	// Put in the Access Code provided by CCAVENUES
	 String workingKey = "391C34ABC8DD370712F2AB0E160F18E2";    // Put in the Working Key provided by CCAVENUES								 
	                                                            
	 Enumeration enumeration=request.getParameterNames();
	 String ccaRequest="", pname="", pvalue="";
	 while(enumeration.hasMoreElements()) {
	      pname = ""+enumeration.nextElement();
	      pvalue = request.getParameter(pname);
	      ccaRequest = ccaRequest + pname + "=" + pvalue + "&";
	 }
	 AesCryptUtil aesUtil=new AesCryptUtil(workingKey);
	 String encRequest = aesUtil.encrypt(ccaRequest);
	%>
	<center>
		<br><br>
      	<!-- width required mininmum 482px -->
       	<iframe  width="482" height="500" scrolling="No" frameborder="0"  id="paymentFrame" src="https://secure.ccavenue.com/transaction/transaction.do?command=initiateTransaction&merchant_id=<%= merchantId %>&encRequest=<%=  encRequest %>&access_code=<%= accessCode %>">
	  	</iframe>
	</center>
	
	<script type="text/javascript">
    	$(document).ready(function(){
    		$('iframe#paymentFrame').load(function() {
				 window.addEventListener('message', function(e) {
			    	 $("#paymentFrame").css("height",e.data['newHeight']+'px'); 	 
			 	 }, false);
			 }); 
    	});
	</script>
</body> 
</html>
