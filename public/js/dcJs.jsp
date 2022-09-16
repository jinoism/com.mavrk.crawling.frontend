<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
		
	var g_receiveKind1  = [{ 
			id: 0,	 	
			text : '선택'
	
		},	{ 
		id: 1,	 	
		text : '일회성수납'
	
		}, {   
			id: 2,	 		
			text : '멤버쉽수납'		 		 	
		}
		]; 
	
	var g_receiveKind2  = [{ 
			id: 0,	 	
			text : '선택'
	
		},{ 
			id: 3,	 	
			text : '멤버쉽환불' 	
		}, {   
			id: 4,	 		
			text : '일반환불'		 		 	
		}
	];
	
	var g_paymentType1  = [{ 
			id: 0,	 	
			text : '선택'
	
		},{ 
			id: 3,	 	
			text : '현금' 	
		}, {   
			id: 4,	 		
			text : '카드'		 		 	
		}, {   
			id: 5,	 		
			text : '무통장'		 		 	
		}
	];
	
	//var g_maxTextLength = 90; // 최대 문자열길이(byte)
	
	function getCustomerSmsSendHistory(){
    	
    	var custid = $('#gmcustid').textbox('getValue'); // 고객아이디
    	
    	$('#dgSmsSendHistory').datagrid({
    		url: '/customer/getCustomerSmsSendHistory.do',
    		method: 'get',
    		queryParams: {
         		  
         		  custid: custid
         		
    		}
    		
    	});
    }
    
	// 고객용 문자발송
	function sendCustomerSms(){
		
		var mobileno = $('#csmobileno').textbox('getValue');
		mobileno = mobileno.replace(/-/gi,'');
		var content = $('#cssmscontent').textbox('getValue');
		
		if(content.length == 0){
			alert('sms 메시지를 입력해 주세요');
			return;
		}
		
		var custid = g_custid;
		
		$('#btnSendCustomerSms').linkbutton('disable');
		$.ajax({
			url : "/customer/sendCustomerSmsMessage.do",
			type : "POST",
			dataType : "json",
			data: {
				custid: custid,
				mobileno: mobileno,			
				content: content
			},
			success : function(response){
				if(response.errmsg){
					alert('메시지 발생시 에러가 발생했습니다.' + 'code:' 
							+ response.errcd + ' ' + response.errmsg);
					return;
				}
				clearSmsContent();
				alert('메시지를 발송했습니다.');
        		
			},
			error: function(xhr, status, thrown) {							
				alert('발송 중 문제가 발생했습니다.')
			},
			complete :function(){		
				$('#btnSendCustomerSms').linkbutton('enable');
			}
		});
	}
	
	// 매니저용 문자발송
	function sendManagerSms(){
		
		var mobileno = $('#msmobileno').textbox('getValue');
		mobileno = mobileno.replace(/-/gi,'');
		var content = $('#mssmscontent').textbox('getValue');
		var managerid = $('#msmanagerid').val();
		
		if(content.length == 0){
			alert('sms 메시지를 입력해 주세요');
			return;
		}
		
		var custid = g_custid;
		
		$('#btnSendManagerSms').linkbutton('disable');
		
		$.ajax({
			url : "/customer/sendManagerSmsMessage.do",
			type : "POST",
			dataType : "json",
			data: {
				custid: custid,
				mobileno: mobileno,
				managerid: managerid,
				content: content
			},
			success : function(response){
				if(response.errmsg){
					alert('메시지 발생시 에러가 발생했습니다.' + 'code:' 
							+ response.errcd + ' ' + response.errmsg);
					return;
				}
				clearManagerSmsContent();
				alert('메시지를 발송했습니다.');
        		
			},
			error: function(xhr, status, thrown) {							
				alert('발송 중 문제가 발생했습니다.')
			},
			complete :function(){		
				$('#btnSendManagerSms').linkbutton('enable');
			}
		});
	}
	
	
	// 1: 부재안내 2: 미납금안내 3:카드오류 4: 한도초과 5: 잔액부족 6:재출금안내
	
	
	function setMySms(stype, content){
		
		if (stype == '1'){
			$('#csmysmsabsent').textbox('setValue', content);
		}else if (stype == '2'){
			$('#csmysmsunpaid').textbox('setValue', content);
		}else if (stype == '3'){
			$('#csmysmscarderror').textbox('setValue', content);
		}else if (stype == '4'){
			$('#csmysmslimitexceed').textbox('setValue', content);
		}else if (stype == '5'){
			$('#csmysmsbalanceshortage').textbox('setValue', content);
		}else if (stype == '6'){
			$('#csmysmsrewithdraw').textbox('setValue', content);
		}
	}
	
	// 나만의 SMS 모두 불러오기 / 설정을 위해 불러오는 용도임
	function getMyAllSms(){
		$.ajax({
			url : "/customer/getMyAllSms.do",
			type : "POST",
			dataType : "json",
			data : {
				
			},
			success : function(response){
				if(response == null){
					alert('나만의 문자를 불러 오는데 실패했습니다.');
					return;
				}
				var list = response.list;
				for (var i = 0; i< list.length; i++ ){
					setMySms(list[i].stype, list[i].content);
				}
				
			},
			error: function(xhr, status, thrown) {
				alert('시스템에러로 나만의 문자를 가져오는데 실패했습니다.');
			},
			complete :function(){
			}
		});
	}
	
	// SMS 타입별로 불러오기
	function getMySms(stype){
		$.ajax({
			url : "/customer/getMySms.do",
			type : "POST",
			dataType : "json",
			data : {
				  stype : stype,
				
			},
			success : function(response){
				if(response.errcd != 'ERR_0000'){
					alert('상용구를 가져오는데 실패했습니다.');
					return;
				}
				var content = response.content;
				
				var contentByteLengh = getByteLength(content);
				
				//if (content.length > g_maxTextLength ){
				//	content = content.substring(0, g_maxTextLength);					
				//}
				
				content = cutByteLength(content, g_maxTextLength);
					
				$('#cssmscontent').textbox('setValue', content);
				//$('#cssmslength').text(content.length);
				$('#cssmslength').text(contentByteLengh);
								
			},
			error: function(xhr, status, thrown) {
				alert('시스템 에러로 상용구를 가져오는데 실패했습니다.');
			},
			complete :function(){
			}
		});
	}
	
	
	// 방문확정
	function getSmsVisitConfirm(){
		//var content = '[확정]최달식님/010-3310-8677/강북구/매트리스/13일17시00분으로 예약확정안내되었습니다.';
		var custName = $('#gmcustnm').textbox('getValue');
		var custMobileNo = $('#gmmobileno').textbox('getValue');
		var custArea = '';
		var visitDate = '';
		var prodGroupName = $('#msprodgroupnm').textbox('getValue');
		
		visitDate = $('#mscarereqdt').textbox('getValue') + ' ' + $('#mscarereqtime').textbox('getValue');
		
		
		var content = '';
		content = '[확정]' + custName + '님/' + custMobileNo +  '/' + prodGroupName + '/' + visitDate + 
						'으로 예약확정안내되었습니다';
		$('#mssmscontent').textbox('setValue', content);
		$('#mssmslength').text(content.length);
	}
	
	// 배정안내
	function getSmsAllocatioinInform(){
		//var content = '[컨택요청] OOO님/010-3310-8677/OOO/OOOO/긴급컨택요청';
		var custName = $('#gmcustnm').textbox('getValue');
		var custMobileNo = $('#gmmobileno').textbox('getValue');
		var custArea = '';
		var visitDate = '';
		var prodGroupName = $('#msprodgroupnm').textbox('getValue');
		var content = '';
		content = '[컨택요청]' + custName + '님/' + custMobileNo + '/'  + prodGroupName + '/' + '컨택요청';
		$('#mssmscontent').textbox('setValue', content);
		$('#mssmslength').text(content.length);
	}
	
	// 나만의 SMS 저장 - 타입별로 저장한다. 
	function saveMySms(stype){
		var content = ''
		if(stype == '1'){ // 부재안내
			content = $('#csmysmsabsent').textbox('getValue');
		}else if (stype == '2'){ // 미납금안내
			content = $('#csmysmsunpaid').textbox('getValue');
		}else if (stype == '3'){ // 카드오류
			content = $('#csmysmscarderror').textbox('getValue');
		}else if (stype == '4'){ // 한도초과
			content = $('#csmysmslimitexceed').textbox('getValue');
		}else if (stype == '5'){ // 잔액부족
			content = $('#csmysmsbalanceshortage').textbox('getValue');
		}else if (stype == '6'){ // 재출금안내
			content = $('#csmysmsrewithdraw').textbox('getValue');
		}else{
			alert('알 수 없는 종류의 문자입니다.');
			return;
		}
		
		if (content.length == 0){
			alert('저장할 문자가 없습니다.');
			return;
		}
		
		$.ajax({
			url : "/customer/saveMySms.do",
			type : "POST",
			dataType : "json",
			data : {
				  stype : stype,
				  content: content
				
			},
			success : function(response){
				if(response.errcd != 'ERR_0000'){
					alert('나만의 문자를 저장하는데 실패했습니다.');
					return;
				}
				alert('나만의 문자를 저장했습니다');				
			},
			error: function(xhr, status, thrown) {
				alert('나만의 문자를 저장하는데 실패했습니다.');
			},
			complete :function(){
			}
		});
	}
	
	
	function getTomorrow(){
		var today = moment().add(1,'days').format('YYYY-MM-DD');
		return today;
	}
	
	function getPrevYearMonth(){
		var prevYearMonth = moment().subtract(1, 'months').endOf('month').format('YYYY-MM');	 
		return prevYearMonth;
	}
		
	var g_memcost = []; // 멤버십가격
	var g_gencost = []; // 일반가격
	var g_allItemDtlList = []; // 아이템목록
	var g_allPatternCodeList = []; // 패턴코드목록
	var g_bankCardList = []; // 은행카드사목록
	var g_counselLargeType = []; // 상담대분류
	var g_counselMiddleType = []; // 상담중분류
	var g_counselSmallType = []; // 상담소분류
	var g_saleUserList = []; // 멤버
	var g_custid ;
	var g_showclose = 0;
	var g_jsonAccount;
	
	
	// 상담 - 대분류로 중분류얻기
	function getCounselMiddleTypeByLargeType(parentId){
		return g_counselMiddleType.filter(
			      function(g_counselMiddleType){ return g_counselMiddleType.parent_id == parentId }
		);
	}
	
	// 상담 - 중분류로 소분류얻기
	function getCounselSmallTypeByMiddleType(parentId){
		return g_counselSmallType.filter(
			      function(g_counselSmallType){ return g_counselSmallType.parent_id == parentId }
		);
	}
	
	function getProdCdByProdGroup_notuse(prodgroup) {
		  return g_allItemDtlList.filter(
		      function(g_allItemDtlList){ return g_allItemDtlList.prodgroup == prodgroup }
		  );
	}
	
	function getProdCdByProdGroup(prodgroup, y_all) {
		  // [y_all] Y: 사용하는 것만 ALL: 전체
		  return g_allItemDtlList.filter(
		      function(g_allItemDtlList){ 
					if (y_all == 'Y'){
						return g_allItemDtlList.prodgroup == prodgroup && g_allItemDtlList.use_yn == 'Y'
						
					}else{
						return g_allItemDtlList.prodgroup == prodgroup 
					}
				}
		  );
	}
	
	function getPatternCode(nrulecd, prodgroup) {
		  return g_allPatternCodeList.filter(
		      function(g_allPatternCodeList){ return g_allPatternCodeList.nrulecd == nrulecd 
		    	  										&&  g_allPatternCodeList.prodgroup == prodgroup
		      }
		  );
	}
	
	// ccid: BANKCD, CARDCD
	function getBankCardCdByCodeClassId(ccid) {
		  return g_bankCardList.filter(
		      function(g_bankCardList){ return g_bankCardList.code_class_id == ccid }
		  );
	}
	
	
	
	// 고객정보 불러온다.
	
	function getCustInfo(custid){
		showTimer();
		$('#dlgCustomerSms').dialog('close');
		
		$.ajax({
			url : "/customer/getCustInfo.do?custid="+custid,
			type : "POST",
			dataType : "json",
			data: {
				
			},
			success : function(response){
				
				g_custid = custid;
			    
				var customer = response.customer;
				g_jsonAccount = response.account;
				g_showclose = 0;
				
				$('#btnCustomerSms').show();
				$('#btnEditCustomer').show();
		    	$('#btnSearchCustInfoHist').show();
		    	$('#btnInitCustomerDetail').show();
		    	$('#btnRefreshCustomerDetail').show();
		    	
				clearPayRecvText();
				clearDgPayRecvRelative();
				initFormContract();
				
			    initFormCounsel(customer); // 상담폼
			    
			    $('#dgCounsel').datagrid('loadData', []);
			    $('#dgContract').datagrid('loadData', []);
			    $('#dgGeneralContract').datagrid('loadData', []);
			    $('#dgPayContract').datagrid('loadData', []);
			    $('#dgPayGeneralContract').datagrid('loadData', []);
			    
			    $('#dgCounsel').datagrid({data: response.counselList}); // 상담정보
			    $('#dgContract').datagrid({data: response.contractList}); // 계약정보 - 멤버쉽
			    $('#dgGeneralContract').datagrid({data: response.generalContractList}); // 계약정보 - 일반
			    $('#dgPayContract').datagrid({data: response.payContractList}); // 납부정보 - 멤버쉽
			    $('#dgPayGeneralContract').datagrid({data: response.payGeneralContractList}); // 납부정보 - 일반
			    
			    
			    clearAccountInfoHist(); // 계정이력 클리어	    
			    clearDgRecvList(); // 접수정보(하단)
			    clearCloseInfo(); // 해지정보(하단) 
			    clearDgContactList(); // 컨택현황(하단)
				
				initCustAccount(); // 계정정보
				initCustBasicInfo(customer); // 상단 고객정보
				
				$('#custmaintab').tabs('select', '계약정보');
        		
			},
			error: function(xhr, status, thrown) {							
				alert('서버와의 통신 중 문제가 발생했습니다.')
			},
			complete :function(){		
				hideTimer();
				closeSearchCustDlg();
			}
		});

	}
	
	function initCustBasicInfo(customer){
		$('#fmGmCustBasic').form('clear');
		$('#fmGmCustBasic').form('load', customer);
	}
	// 고객검색창 닫기
    function closeSearchCustDlg(){
    	$('#dlgSearchCust').dialog('close');
    	$('#dgCustomer').datagrid('loadData', []);
    	
    	$('#sccustnm').textbox('setValue', '');
    	$('#sccustid').textbox('setValue', '');
    	$('#scmobileno').textbox('setValue', '');
    	$('#sctelno').textbox('setValue', '');
    	$('#sccontractno').textbox('setValue', '');
    	$('#scordr_no').textbox('setValue', '');
    }
	///////////////////////////////////////////////
	//////////////////////////// 
	///////////////////////////////////////////////
    // sofdoc
    var g_orgList;

	
    function sumAddProduct(){
    	var sumTotal=0;
    	
    	$("input[name='addproductcost']").each(function(index){
    		var tmpTotal =0;
    		tmpTotal = tmpTotal + parseInt($(this).val());
    		if(isNaN(tmpTotal)){
    			sumTotal = sumTotal + 0;
    		}else{
    			sumTotal = sumTotal + tmpTotal;
    		}

    	})
    	alert(sumTotal);
    	$("#addtotalcost").val(sumTotal);
    	$("#addtotalcosttxt").html(sumTotal.toLocaleString());
    	calGenCareFee2();
    }
 // 일반 - 서비스 금액 계산
    function calGenCareFee2(){
    	var genlistprice = $('#newcontractgencost').textbox('getValue');
    	var dcprice = $('#newcontractdcprice').textbox('getValue');
    	if(isEmpty(dcprice)){
    		dcprice = 0;
    	}
    	var carefee = genlistprice - dcprice;
    	$('#newcontractgencarefee').textbox('setValue', carefee + parseInt($("#addtotalcost").val()));
    }
    
    
    function delAddProduct(obj){
    	$(obj).closest('div').remove();
    	sumAddProduct();
    	addEvent();
    }
    var delArr = new Array();
    function delAddProductId(obj){

    	var delIdx = $(obj).prev().prev().prev().prev().prev().prev().prev().val();
    	delArr.push(delIdx);
    	$("#delAddProductId").val(delArr);
    	
    	
    	$(obj).closest('div').remove();
    	sumAddProduct();
    	addEvent();
    }
    
    function addEvent(){
    	$("input:text[numberOnly]").on("focus", function() {
    	    var x = $(this).val();
    	    $(this).val(x);
    	}).on("focusout", function() {
    	    var x = $(this).val();
    	    if(x && x.length > 0) {
    	        if(!$.isNumeric(x)) {
    	            x = x.replace(/[^0-9]/g,"");
    	        }
    	        $(this).val(x);
    	    }
    	}).on("keyup", function() {
    	    $(this).val($(this).val().replace(/[^0-9]/g,""));
    	});
    }
	
    $(document).ready(function(){
    	addEvent();
    	$('#plash').hide();
    	$('#divChgContractGeneral').hide();
	    
	    
	    // 고객화면 디버깅 활용
	    
	    var custid = $('#gmcustid').textbox('getValue');
	    if (custid != ''){
	    	g_custid = custid;
	    	refreshCustomerDetail();
	    }
	    
	    // e. 고객화면 디버깅 활용
	    
	    // 고객검색
	    $('#dgCustomer').datagrid({
        	onDblClickRow: function(index, row){
        		
        		// 내가 상세 조회로 갈 수 있는 고객인지 확인한다.
       			$.ajax({
					url : "/customer/isCustomerServiceAreaOfOrg.do",
					type : "POST",
					dataType : "json",
					data: {
						zipcd: row.zipcd,
					},
					success : function(response){
						
						if (response.result != '1'){
							alert('기관의 담당 고객이 아니라서 상세조회를 할 수 없습니다.');
							return;
						}
						
						getCustInfo(row.custid);
		        		
					},
					error: function(xhr, status, thrown) {							
						alert('서버와의 통신 중 문제가 발생했습니다.')
					},
					complete :function(){		
						
					}
				});
        		
        		
        	}
        });
	    
	    $("#zip_find").click(function() {
			daum.postcode.load(function(){
				new daum.Postcode({
					oncomplete: function(data) {
						$('#bazipcd').textbox('setValue', data.zonecode);
						$('#baaddr1').textbox('setValue', data.address);
					}
				}).open();
			});
		});
        
     	// 검색버튼눌렀을시
    	$('#btnCustSearch').bind('click', function(){
    		doSearchCust();
        });
	    
    	$('#btnProductSearch').bind('click', function(){
    		
    	});
     	
    	$('#btnCustomerSms').hide();
    	$('#btnEditCustomer').hide();
    	$('#btnSearchCustInfoHist').hide();
    	$('#btnInitCustomerDetail').hide();
    	$('#btnRefreshCustomerDetail').hide();
     	
	    
	    
	    
	    // https://www.jeasyui.com/forum/index.php?topic=3648.0  
	    $('#gmcustnm').textbox('textbox').css({'color': 'black'});
	    $('#gmcustid').textbox('textbox').css({'color': 'black'});
	    $('#gmmobileno').textbox('textbox').css({'color': 'black'});
	    $('#gmtelno').textbox('textbox').css({ 'color': 'black'});
	    $('#gmaddr').textbox('textbox').css({ 'color': 'black'});
	    
	    $('#payvalidyyyymm').textbox('textbox').attr('maxlength',6); // 카드유효기간최대길이 설정
	    $('#tgvalidyyyymm').textbox('textbox').attr('maxlength',6); // 카드유효기간최대길이 설정
	    
				    
	    //var jsonAccount = '${jsonAccount}';	// sss
	    //g_jsonAccount = JSON.parse(jsonAccount); // sss
	    
	    var jsonOrgList = '${jsonOrgList}';
	    var jsonSaleUser = '${jsonSaleUser}';
	    
	    var jsonAllItemDtlList = '${jsonAllItemDtlList}';
	    var jsonAllPatternCodeList = '${jsonAllPatternCodeList}';
	    var jsonAllMemCostList = '${jsonAllMemCostList}';
	    var jsonAllGenCostList = '${jsonAllGenCostList}';		    
	    var jsonBankCardList =   '${jsonBankCardList}';
	    var jsonLargeTypeList = '${jsonLargeTypeList}';
	    var jsonMiddleTypeList = '${jsonMiddleTypeList}';
	    var jsonSmallTypeList = '${jsonSmallTypeList}';
	    		    
	    g_orgList = JSON.parse(jsonOrgList);
	    g_allItemDtlList = JSON.parse(jsonAllItemDtlList);
	    g_allPatternCodeList = JSON.parse(jsonAllPatternCodeList);
	    g_memcost = JSON.parse(jsonAllMemCostList);
	    g_gencost = JSON.parse(jsonAllGenCostList);
	    g_bankCardList = JSON.parse(jsonBankCardList);			
		g_counselLargeType =  JSON.parse(jsonLargeTypeList); 
		g_counselMiddleType = JSON.parse(jsonMiddleTypeList);
		g_counselSmallType =  JSON.parse(jsonSmallTypeList);
		
		
		$('#cotakeuserid').combobox('disable');
        $('#cotransdt').datebox('disable');
        $('#cotranstime').timespinner('disable');	 
		
		$('#cotaskgb').combobox({
			onChange : function (newVal, oldVal){	        		
        		if (newVal == '1'){ // 부서이관
        			
        	    	var today = getToday();
        	    	var callstart = moment().format('HH:mm');
        	    	
        	    	$('#cotransdt').datebox('setValue', today);	    	
        	    	$("#cotranstime").timespinner('setValue', callstart);	        	    	
        	    	$('#cotakeuserid').combobox('enable');
        			$('#cotransdt').datebox('enable');
        			$('#cotranstime').timespinner('enable');	        		
        				        		
        		}else{
        			$('#cotakeorgancd').val('');
        			$('#cotakeuserid').combobox('setValue','');
        			$('#cotransdt').datebox('setValue', '');
        			$('#cotranstime').timespinner('setValue', '');
        			$('#cotakeuserid').combobox('disable');
        			$('#cotransdt').datebox('disable');
        			$('#cotranstime').timespinner('disable');	        			
        		}
			}
		});
		
		$('#cotaskgb').combobox('setValue', '2');
		
		initAccountHandleUser();
		
		//getBankCardCdByCodeClassId('BANKCD');
		//getBankCardCdByCodeClassId('CARDCD');
		// fmAccount form load 하기 전에 combo 설정을 먼저해야 한다.
		$('#acpaymenttype').combobox({
        	onChange : function (newVal, oldVal){	        		
        		if (newVal == '1'){ // 자동이체
        			$('#divAcBank').show();
        			$('#divAcCard').hide();
        			bankCardComboLoading(newVal);
        		}else if(newVal == '2'){ // 카드이체
        			$('#divAcBank').hide();
        			$('#divAcCard').show();
        			bankCardComboLoading(newVal);
        		}else{
        			$('#divAcBank').show();
        			$('#divAcCard').show();
        		}	
        	} 
		});
		
		
		
    	$('#newcontractcontractdt').datebox('setValue', getToday());
    	
    	$('#custGb').combobox({
    		editable: false
    	});
    	
    	
    	// 검색버튼눌렀을시
    	$('#btnCustSearch').bind('click', function(){
    		$('#dlgCustProduct').dialog('open').dialog('center').dialog('setTitle','상품등록');    	
        });
        
    	// 고객등록 눌렀을시
        $('#btnNewCust').bind('click', function(){
        	$('#dlgCustBasic').dialog('open').dialog('center').dialog('setTitle','고객등록');	
        });
        
        	        
        // 계약변경탭 - 저장
        $('#btnSaveChangeContract').click(function(){
        	saveChgContract();
        });
        
        $('#btnSaveAccount').click(function(){	        	
        	saveAccount();
        });
        
        $('#btnConfirmAccount').click(function(){	        	
        	confirmAccount();
        });
        $('#btnAddProduct').click(function(){	        	
        	$("#addproductbasic").html();
        	console.dir($("#addproductbasic").html());
        	var str = '<div style="margin-bottom:10px" id="addproductpart">'  +$("#addproductbasic").html() +'</div>';
        	$("#addproductdiv").append(str);
        	addEvent()
        	
        });
        
        var addTotal = 1;
        $("#addproductbasic").hide();
        $("#prodbox").hide();
            	
        	
     
 
        
        $('#btnCancelCounsel').click(function(){
        	
        	$('#dlgCustCounsel').dialog('close');
        });
        
        // 해지저장
		$('#btnReqClose').click(function(){
			alert('사용하지 않는 기능입니다');
			return;
        	//saveCloseContract();	        	
        });
        	        
        
        
		$('#recvcareorgancd').textbox('hide');
		
        
        $('#nrulecd').combobox({
        	onChange : function (newVal, oldVal){
        		
        		if (newVal == 1){
        			
        			$('#divMembership').show();
        			$('#divGeneral').hide();
        			$("#addtotalcost").val(0);
        			$("#addtotalcosttxt").html(0);
        		}else {
        			$('#divMembership').hide();
        			$('#divGeneral').show();
        			
        		}
        		alert( $('#newcontractprodgroup').combobox('getValue'))
        		
        	} 
        });
        
        // 규정 변경시
        $('#newcontractnrulecd').combobox({
        	onChange : function (newVal, oldVal){
        		
        		$('#newcontractprodcd').combobox('setValue', '');
        		
        		if (newVal == 1){ // 멤버십
        			
        			$('#divNewContractMembership').show();
        			$('#divNewContractFile').show();
        			$('#divNewContractGeneral').hide();
        			$('#newcontractserviceperiod').numberbox('readonly',false);
        			$('#newcontractot_srv_turn').numberbox('readonly',true);
        			$('#prodbox').hide();
        			$("#addtotalcost").val(0);
        			$("#addtotalcosttxt").html(0);
        			$("#addproductdiv").find('div').each(function(index){
        				if(index > 0){
        					$(this).remove();
        				}
        			})
        			
        			
        		}else {// 일반
        			
        			$('#divNewContractMembership').hide();
        			$('#divNewContractFile').hide();
        			$('#divNewContractGeneral').show();	        			
        			$('#newcontractdcrate').combobox('select', ''); 
        			
        			$('#newcontractserviceperiod').numberbox('readonly',true);
	        		$('#newcontractot_srv_turn').numberbox('readonly',true);
	        		
	        		if($('#newcontractprodgroup').combobox('getValue')==5){
	        			$('#prodbox').show();
	        			$("#addtotalcost").val(0);
	        			$("#addtotalcosttxt").html(0);
	        		}
        			
        		}
        		
        		// 규정 변경시 패턴코드설정
        		var nrulecd = newVal;
        		var prodgroup = $('#newcontractprodgroup').combobox('getValue');
        		var joPattenCode = getPatternCode(nrulecd, prodgroup);
        		$('#newcontractpt_code').combobox({
        			valueField: 'pt_code',
        			textField: 'pt_nm',
        			data: joPattenCode
        		});
        		
        		// 규정을 바꾸면 패턴은 사용자가 재설정하도록함
        		$('#newcontractpt_code').combobox('setValue', '');
        	} 
        });
        
        
        
        // 신규계약다이얼로그의 상품그룹 선택시
        $('#newcontractprodgroup').combobox({
        	onChange : function (prodgroup, oldVal){
        		var joItemDtl = getProdCdByProdGroup(prodgroup, 'Y');
        		$('#newcontractprodcd').combobox({
        			valueField: 'prodcd',
        			textField: 'prodnm',
        			data: joItemDtl
        		});
        		
        		var nrulecd = $('#newcontractnrulecd').combobox('getValue');
        		var joPattenCode = getPatternCode(nrulecd, prodgroup);
        		$('#newcontractpt_code').combobox({
        			valueField: 'pt_code',
        			textField: 'pt_nm',
        			data: joPattenCode
        		});
        		
        		if (prodgroup == '5'){
        			$('#newcontractqy_py').textbox({label:'평'});
        		}else{
        			$('#newcontractqy_py').textbox({label:'수량'});
        		}
        		
        		// 상품그룹을 바꾸면 패턴은 사용자가 재설정하도록함
        		$('#newcontractpt_code').combobox('setValue', '');
        		
        		getCareOrgAndManager(); // 상품그룹에 따라 담당매니저 변경
        		
        		var zipcd = $('#gmzipcd').val();
        		getAreaRemarks(zipcd, prodgroup, 'C'); // 권역특이사항
        		if(prodgroup != '5' || $('#newcontractnrulecd').combobox('getValue') =='1'){
        			$("#addtotalcost").val(0);
        			$("#addtotalcosttxt").html(0);
        			$("#prodbox").hide()
        			$("#addproductdiv").find('div').each(function(index){
        				if(index > 0){
        					$(this).remove();
        				}
        			})
        		}else if(prodgroup == '5' || $('#newcontractnrulecd').combobox('getValue') =='2'){
        			$("#addtotalcost").val(0);
        			$("#addtotalcosttxt").html(0);
        			$("#prodbox").show()
        		}
        	} 
        });
        
        // 패턴코드 변경시
        $('#newcontractpt_code').combobox({
        	onChange : function (pt_code, oldVal){
        		var nrulecd = $('#newcontractnrulecd').combobox('getValue');
        		var prodgroup = $('#newcontractprodgroup').combobox('getValue');
        		
        		// 일반이면
        		if (nrulecd == '2'){
        			reqGenTotSrvTurn(pt_code, prodgroup);
        		}
        	} 
        });
        
        var prodgroup = '1';
        var nrulecd = '2';
        var joItemDtl = getProdCdByProdGroup(prodgroup, 'Y');
        var joPattenCode = getPatternCode(nrulecd, prodgroup);
        
   		$('#newcontractprodcd').combobox({
   			valueField: 'prodcd',
   			textField: 'prodnm',
   			data: joItemDtl,
			onChange : function (prodcd, oldVal){
        		
				$('#newcontractserviceperiod').combobox('setValue', '0');
				$('#newcontractmemcost').textbox('setValue', '');
				$('#newcontractmemcarefee').textbox('setValue', '');
				//일반
				$('#newcontractdcrate').combobox('setValue', ''); // 할인율=>선택으로 변경
				$('#newcontractdcprice').textbox('setValue', '');
				$('#newcontractgencost').textbox('setValue', '');
				$('#newcontractgencarefee').textbox('setValue', '');

        	}
   		});
   		
   		$('#newcontractpt_code').combobox({
   			valueField: 'pt_code',
   			textField: 'pt_nm',
   			data: joPattenCode
   		});
   		
       
        // prodgroup 선택 - 1번 선택
        $('#newcontractprodgroup').combobox('select', '1');
        
        $('#newcontractserviceperiod').combobox('select','1' );
        $('#newcontractserviceperiod').combobox('readonly', true);
        
        // 계약기간변경시
        
        $('#newcontractconperd_cd').combobox({
        	onChange : function (prodcd, oldVal){
        		
        		$('#newcontractmemcost').textbox('setValue', '');
        		$('#newcontractmemcarefee').textbox('setValue', '');
        		$('#newcontractmemtotcarefee').textbox('setValue', '');
        		$('#newcontractserviceperiod').combobox('setValue', '0');
        		$('#newcontractot_srv_turn').numberbox('setValue', '');
        		
        	}
        });
        
        // 서비스주기변경시
        $('#newcontractserviceperiod').combobox({
        	onChange : function (newVal, oldVal){
        		
        		if ( $('#newcontractnrulecd').combobox('getValue') == '1'){
        			// 멤버십 - 서비스비용계산

	        		var cornPerdCd = $('#newcontractconperd_cd').combobox('getValue');
	        		
	        		if (cornPerdCd != '9'){ // 설정없음아님
	        			var servicePeriod = $('#newcontractserviceperiod').combobox('getValue');
                           var memListPrice = getMemListPrice();
                           var memCareFee = memListPrice * servicePeriod;
                           var srvTurn = cornPerdCd * 12 / servicePeriod;
                           var memtotcarefee = memCareFee * srvTurn ;
                           $('#newcontractmemcost').textbox('setValue', memListPrice);
                           $('#newcontractmemcarefee').textbox('setValue', memCareFee);
		        		$('#newcontractot_srv_turn').numberbox('setValue', srvTurn);
		        		$('#newcontractmemtotcarefee').numberbox('setValue', memtotcarefee);
	        		}
        		}else if ( $('#newcontractnrulecd').combobox('getValue') == '2') {
        			//calcGenListPrice();
        			//calDcPrice();
        		}
        		
        		
        		
        	}
        });
     	

        
        // 일반 - 할인금액 계산
        function calDcPrice(){
        	var dcprice = 0 ;
        	var genlistprice = $('#newcontractgencost').textbox('getValue');
        	var dcrate = $('#newcontractdcrate').combobox('getValue');
        	if (dcrate != "999" && dcrate != "997" && dcrate != "998"){
        		dcprice = parseInt(genlistprice * dcrate /100);	      
	        	$('#newcontractdcprice').textbox('setValue', dcprice);
        	}
        	if( dcrate == '997'){
        		$('#newcontractdcprice').textbox('setValue', 50000);
        	}
        	if( dcrate == '998'){
        		$('#newcontractdcprice').textbox('setValue', 100000);
        	}
        	calGenCareFee();
        }
        
        // 일반 - 서비스 금액 계산
        function calGenCareFee(){
        	var genlistprice = $('#newcontractgencost').textbox('getValue');
        	var dcprice = $('#newcontractdcprice').textbox('getValue');
        	if(isEmpty(dcprice)){
        		dcprice = 0;
        	}
        	var carefee = genlistprice - dcprice;
        	console.dir("carefee"+carefee);
        	$('#newcontractgencarefee').textbox('setValue', carefee + parseInt($("#addtotalcost").val()));
        }
        

        function getQyPy(){
        	var qy_py = $('#newcontractqy_py').textbox('getValue');
        	
        	if (isEmpty(qy_py)){
        		return 0;
        	}
        	else{
        		return qy_py;
        	}
        		
        }
        
        // 멤버십 소비자가
        function getMemListPrice(){
        	var prodgroup = $('#newcontractprodgroup').combobox('getValue');
        	var prodcd  = $('#newcontractprodcd').combobox('getValue');
        	var serviceperiod = $('#newcontractserviceperiod').combobox('getValue');
        	return getMemCostByCode(prodgroup, prodcd, serviceperiod)[0] == null ? 
        			0: getMemCostByCode(prodgroup, prodcd, serviceperiod)[0].care_cost * getQyPy();
        }
        
        //  일반 소비자가
        function _genListPrice(){	        	
        	var prodgroup = $('#newcontractprodgroup').combobox('getValue');
        	var prodcd  = $('#newcontractprodcd').combobox('getValue');	        	
        	return getGenCostByCode(prodgroup, prodcd)[0] == null ?
        			0: getGenCostByCode(prodgroup, prodcd)[0].care_cost * getQyPy();
        }
        
    	//  일반 소비자가 설정
        function calcGenListPrice(){
        	var genListPrice = _genListPrice();
        	$('#newcontractgencost').textbox('setValue', genListPrice);
        }
        
       
       // 계약변경의 nrulecd 변경시 
        $('#chgcontractnrulecd').combobox({
        	onChange : function (newVal, oldVal){
        		
        		if (newVal == 1){
        			
        			$('#divChgContractMembership').show();
        			$('#divChgContractGeneral').hide();
        			
        		}else {
        			$('#divChgContractMembership').hide();
        			$('#divChgContractGeneral').show();
        		}
        	} 
        });
    		     	
        $('#realaccountyn').switchbutton({
        	setValue : function (val){
        		//console.log('realaccountyn val:' + val);
        	}
        });
        
        $('#dlg').dialog('close');
        
       // 접수
       
   	   // 매니저 스케줄조회
       $('#manager_schedule_btn').click(function(){
    	   	
    	   $('#mgswhere').val('C'); // 계약에서 매니저 스케줄 조회  	   			
 	   			viewManagerSchedule();
   	   		
       });
       $('#manager_schedule_btn1').click(function(){
    	   	
    	   $('#mgswhere').val('C1'); // 계약에서 매니저 스케줄 조회  	   			
 	   			viewManagerSchedule();
   	   		
       });
   	   
       // 접수탭 매니저스케줄조회
       $('#recvmanager_schedule_btn').click(function(){
  	   			$('#mgswhere').val('R'); // 회차에서 매니저 스케줄 조회
  	   			
  	   			viewManagerSchedule();
   	   		
       });
   		   
   	   
       $('#dgMgSchedue').datagrid({
			onClickRow: function(index, row){
				getManagerScheduleDetail(row);
			},
			
			onDblClickRow: function(index, row){
				
			}
		});
       
       // 일반
       	function initGenterm(){
			$('#newcontractdcrate').combobox('setValue', '0');
			$('#newcontractdcprice').textbox('setValue', '');	        			
			$('#newcontractgencost').textbox('setValue', '');	        			
			$('#newcontractgencarefee').textbox('setValue', '');	        			
			$('#newcontractserviceperiod').combobox('setValue', '0');	        			
			$('#newcontractot_srv_turn').numberbox('setValue', '1');
		}
       
       // 멤버쉽
       function initMemTerm(){
			$('#newcontractconperd_cd').combobox('setValue', '0');
			$('#newcontractmemcost').textbox('setValue', '');	        			
			$('#newcontractmemcarefee').textbox('setValue', '');	        			
			$('#newcontractmemtotcarefee').textbox('setValue', '');	        			
			$('#newcontractserviceperiod').combobox('setValue', '0');	        			
			$('#newcontractot_srv_turn').numberbox('setValue', '1');   
       }
       	// 수량변경시
		$('#newcontractqy_py').textbox({
			onChange : function (newVal, oldVal){
		
				 
				if (isEmpty($('#newcontractid').val()) == true){
					// 신규계약시에는 초기화를 해 준다.
					if ($('#newcontractnrulecd').combobox('getValue') == '1'){					    	  
	    				initMemTerm();
	    		  	}else{
	    		  		initGenterm();
	    		  	}	
				}else{
					// 계약변경시
					
					if ( $('#newcontractnrulecd').combobox('getValue') == '1'){
	        			// 멤버십 - 서비스비용계산
		        		var cornPerdCd = $('#newcontractconperd_cd').combobox('getValue');
		        		
		        		if (cornPerdCd != '9'){ // 설정없음아님
		        			var servicePeriod = $('#newcontractserviceperiod').combobox('getValue');
                            var memListPrice = getMemListPrice();
                            var memCareFee = memListPrice * servicePeriod;
                            var srvTurn = cornPerdCd * 12 / servicePeriod;
                            var memtotcarefee = memCareFee * srvTurn ;
                            $('#newcontractmemcost').textbox('setValue', memListPrice);
                            $('#newcontractmemcarefee').textbox('setValue', memCareFee);
			        		$('#newcontractot_srv_turn').numberbox('setValue', srvTurn);
			        		$('#newcontractmemtotcarefee').numberbox('setValue', memtotcarefee);
		        		}
	        		}else if ($('#newcontractnrulecd').combobox('getValue') == '2'){
       					// 일반 - 서비스비용계산
	        			initGenterm();
	        		}
					
				}
			}
       });
       
       	
       // 일반의 할인율 변경시
       $('#newcontractdcrate').combobox({
        	onChange : function (newVal, oldVal){	        		
        		
        		
        		calcGenListPrice();
       			calDcPrice();
        		if (newVal == '999'){
        			// 기타일시 수정가능하도록
        			$('#newcontractdcprice').textbox({ editable: true });
        		}else {
        			$('#newcontractdcprice').textbox({ editable: false });	        			
        		}
        		
        	},
        	width: 200
       });
       
       $('#newcontractdcprice').numberbox({
			onChange : function (newVal, oldVal){
		
				// 직접입력인 경우일시 
				if($('#newcontractdcrate').combobox('getValue') == '999' ){
					calcGenListPrice();
					calDcPrice();
					//console.log('here')
				}	    			
			}
       });
       
       // 계약추가팝업의 소비자가 계산
       // 상품그룹과 상품에 따라 소비자가 계산됨
       
       function getMemCostByCode(prodgroup, prodcd, serviceperiod_cd) {	    	   
    	   return g_memcost.filter(
	    	     function(g_memcost) {
	    	         return g_memcost.prodgroup == prodgroup 
	    	         		&& g_memcost.prodcd == prodcd
	    	         		&& g_memcost.serviceperiod_cd == serviceperiod_cd
	    	     }
	       ) 
    	}
       
       function getGenCostByCode(prodgroup, prodcd) {
    	   return g_gencost.filter(
	    	     function(g_gencost) {
	    	         return g_gencost.prodgroup == prodgroup
	    	         	&& g_gencost.prodcd == prodcd
	    	     }
	       ) 
    	}
       
      
       
       
   		 // 방법선택시
        $('#rcpaymenttype').combobox({
        	onChange : function (newVal, oldVal){
        		var ccid ;
        		if(newVal == '3'){ // 현금
        			ccid = 'BANKCD';
        		}else if (newVal == '4'){ // 카드
        			ccid = 'CARDCD';
        		}else if (newVal == '5'){ // 무통장
        			ccid = 'BANKCD'
        		}else{
        			ccid = '';
        		}
        		
        		var item = getBankCardCdByCodeClassId(ccid);
        		
        		$('#rcbankcardcd').combobox({
        			valueField: 'code_id',
        			textField:  'code_name',
        			data: item
        		});
        	} 
        });
       	       
     
       	/////////////////////////////
       	// 수납
       	/////////////////////////////
       	
       	
		
		$('#dgPayRecv').datagrid({
			title: '계약별수납',
			rownumbers: true,
			singleSelect: true,
			height: 200,
			rowStyler:function(index,row){
		        if (row.receivegb == '2'){ // 환불
		            return 'background-color:lightskyblue;color:white';
		        }
		    },
		    columns:[[
		        {field:'id',title:'아이디', hidden:true},
		        {field:'receivegb',title:'수납구분cd', hidden:true},
		        {field:'receivegbnm',title:'수납구분'},
		        {field:'receivekindnm',title:'수납종류'},
		        {field:'paymenttypenm',title:'납부방법'},
		        {field:'paymentdt',title:'수납일자', formatter:dataGridFormatDate},
		        {field:'paymentamt',title:'금액', formatter:formatMoney},
		        {field:'enterid',title:'처리자'},
		        {field:'enternm',title:'처리자명'},
		        {field:'remarks',title:'특이사항'}
		        
		    ]],
			onClickRow : function(index, row){
			}
		});
		
		$('#dgAsService').datagrid({
			title: '계약별서비스정보',
			rownumbers: true,
			singleSelect: true,
			height: 200,
		    columns:[[
		        {field:'id',title:'아이디', hidden:true},
		        {field:'service_turn',title:'회차'},
		        {field:'proc_status_',title:'처리상태'},
		        {field:'care_type_',title:'구분'},
		        {field:'carereqdt',title:'방문희망일', formatter:dataGridFormatDate},
		        {field:'complete_dt',title:'처리일', formatter:dataGridFormatDate},
		        {field:'service_type_cd_',title:'서비스유형'},
		        {field:'carefee',title:'서비스비용', formatter:formatMoney},
		        {field:'careorgannm',title:'케어기관'},
		        {field:'manager_nm',title:'매니저'},
		        
		        
		    ]],
			onClickRow : function(index, row){
			}
		});
		// http://www.jeasyui.com/forum/index.php?topic=3628.0 - answer: stworthy
		

		
		$('#dgChargeInfo').datagrid({
			title: '계약별회차정보',
			rownumbers: false,
			singleSelect: true,
			height: 100,
		    columns:[[
		        {field:'id',title:'아이디', hidden:true},
		        {field:'rentyyyymm',title:'년월', styler:cellStyler},
		        {field:'contractno',title:'계약번호', hidden:true},
		        {field:'saleorgancd',title:'판매기관', hidden:true},
		        {field:'saleyear',title:'년도', hidden:true},
		        {field:'seqno',title:'번호', hidden:true},
		        {field:'rentturns',title:'회차', hidden:true},
		        {field:'rentamt',title:'멤버쉽비용', formatter:formatMoney},
		        {field:'depositamt',title:'당월입금액', formatter:formatMoney},
		        {field:'accrentamt',title:'누적멤버쉽비용', formatter:formatMoney},
		        {field:'realpaiedamt',title:'실수납금액', formatter:formatMoney},
		        {field:'unpaiedturns',title:'연체회차'},
// 		        {field:'munpaiedamt',title:'당월미납금', formatter:formatMoney},
		        {field:'exceedamt',title:'초과입금액', formatter:formatMoney},
		        {field:'accunpaiedamt',title:'총미납금액', formatter:formatMoney},
		        {field:'repaymentamt',title:'당월환불금', formatter:formatMoney},
		        {field:'accrepaymentamt',title:'총환불금액', formatter:formatMoney},
		        {field:'overdueamt',title:'연체금액', formatter:formatMoney},
		        {field:'accdepositamt',title:'총입금액', formatter:formatMoney},
		        {field:'dis_comment',title:'해지코멘트', hidden:true},
		        {field:'custid',title:'custid', hidden:true}

		        
		    ]],
			onClickRow : function(index, row){
			}
		});
		
		$('#dgBasicChargeInfo').datagrid({
			title: '계약별기본회차정보',
			rownumbers: false,
			singleSelect: true,
			height: 150,
		    columns:[[
		        {field:'id',title:'아이디', hidden:true},
		        {field:'rentyyyymm',title:'년월', styler:cellStyler},
		        {field:'contractno',title:'계약번호', hidden:false},
		        {field:'saleorgancd',title:'판매기관', hidden:true},
		        {field:'saleyear',title:'년도', hidden:true},
		        {field:'seqno',title:'번호', hidden:true},
		        {field:'rentturns',title:'회차', hidden:true},
		        {field:'rentamt',title:'멤버쉽비용', formatter:formatMoney},
		        {field:'depositamt',title:'당월입금액', formatter:formatMoney},
		        {field:'accrentamt',title:'누적멤버쉽비용', formatter:formatMoney},
		        {field:'realpaiedamt',title:'실수납금액', formatter:formatMoney},
		        {field:'unpaiedturns',title:'연체회차'},
// 		        {field:'munpaiedamt',title:'당월미납금', formatter:formatMoney},
		        {field:'exceedamt',title:'초과입금액', formatter:formatMoney},
		        {field:'accunpaiedamt',title:'총미납금액', formatter:formatMoney},
		        {field:'repaymentamt',title:'당월환불금', formatter:formatMoney},
		        {field:'accrepaymentamt',title:'총환불금액', formatter:formatMoney},
		        {field:'overdueamt',title:'연체금액', formatter:formatMoney},
		        {field:'accdepositamt',title:'총입금액', formatter:formatMoney},
		        {field:'accunpaiedamt_',title:'수납하기',
		        	formatter: function(value,row,index){
		        		
		        			var callfn = "openDlgChargeInfoBasicPay('{0}')".format(encodeURI(index));
                            var col = '<a href="javascript:void(0)" onclick="' + callfn  + '">' + '수납' +'</a>';
                            return col;	
		        		
                       }
		        
		        },
		        {field:'contractstate_',title:'계약상태'},
		        {field:'dis_comment',title:'해지코멘트', hidden:true},
		        {field:'custid',title:'custid', hidden:true}

		        
		    ]],
			onClickRow : function(index, row){
			}
		});
		
		$('#dgRelativeChargeInfo').datagrid({
			title: '회차관련계약번호',
			rownumbers: false,
			singleSelect: true,
			height: 150,
		    columns:[[
		    	{field:'id',title:'아이디', hidden:true},
		        {field:'contractno',title:'계약번호'},
		        {field:'custnm',title:'고객명', hidden:true},			        
		        {field:'nrulenm',title:'규정'},
		        {field:'contractstatenm',title:'계약상태'},
		        {field:'prodnm',title:'상품명'},
		        {field:'contractdt',title:'계약일자', formatter:dataGridFormatDate},
		        {field:'orgrentamt',title:'할인전비용', formatter:formatMoney},
		        {field:'carefee',title:'할인후비용', formatter:formatMoney}
		        
		    ]],
			onClickRow : function(index, row){
			}
		});
       
		function cellStyler(value,row,index){
            return 'background-color:#ffee00;color:red;';
        }
		
		

		//// 수납다이얼로그처리
		       
       
		// 현금영수증 비활성화
		$('#paycashrcptgb').combobox('select', 'N');
       	$('#paycashrcptgb').combobox('disable');
		
 			$('#paycashrcptno').textbox('disable');
 			$('#paycashapprovalno').textbox('disable');
 			$('#paycashdreq').hide();
 			
 			
 			// 카드 비활성화
 			$('#paybankcardcd').combobox('disable');
 			$('#payaccountno').textbox('disable');
 			$('#payaccountholder').textbox('disable');
 			$('#payvalidyyyymm').textbox('disable');	        			
 			$('#paycardapprovalno').textbox('disable');
 			$('#paycardapprovaldt').datebox('disable');	        			
 			$('#paycardreq').hide();
       
 			$('#payrefundgb').combobox('disable');
 			
 			$('#paypaymentdt').datebox('setValue', getToday());
 			
 		 	
	 	
        $('#payreceivegb').combobox({
        	onChange : function (newVal, oldVal){
        		
        		if (newVal == 1){ // 수납
        			$('#payrefundgb').combobox('select', '0');
        			$('#payrefundgb').combobox('disable');
        			
        			$('#payreceivekind').combobox({
	        			valueField: 'id',
	        			textField: 'text',
	        			data: g_receiveKind1
	        		});
	        		
	        		$('#paypaymenttype').combobox({
	        			valueField: 'id',
	        			textField: 'text',
	        			data: g_paymentType1
	        		});
	        		
	        		$('#divPayRefund').hide();
	        		
        		}else{ // 환불
        			$('#payrefundgb').combobox('enable');
        		
        			$('#payreceivekind').combobox({
	        			valueField: 'id',
	        			textField: 'text',
	        			data: g_receiveKind2
	        		});
        		
        			$('#paypaymenttype').combobox({
	        			valueField: 'id',
	        			textField: 'text',
	        			data: g_paymentType1
	        		});
        			
        			//$('#divPayRefund').show();
        		}
        		g_fitDlgSize('dlgPay');
        	} 
        });
        
        //지불방법선택
        $('#paypaymenttype').combobox({
        	onChange : function (newVal, oldVal){
        		
        		//console.log(newVal)
        		if (newVal == 3){ // 현금
        			$('#paycashrcptgb').combobox('enable');
        			$('#paycashrcptgb').combobox('select', 'Y');
        			$('#paycashrcptno').textbox('disable');
        			$('#paycashapprovalno').textbox('disable');
        			$('#paycashdreq').hide();
        			
        			$('#paybankcardcd').combobox('disable');
        			$('#payaccountno').textbox('disable');
        			$('#payaccountholder').textbox('disable');
        			$('#payvalidyyyymm').textbox('disable');	        			
        			$('#paycardapprovalno').textbox('disable');
        			$('#paycardapprovaldt').datebox('disable');	        			
        			$('#paycardreq').hide();
        			
        			$('#divPayCash').show();
        			$('#divPayCard').hide();
        			$('#divPayRefund').hide();
        			
        		
        		}else if (newVal ==4 ){ // 카드
        			
        			$('#paybankcardcd').combobox('enable');
        			$('#payaccountno').textbox('enable');
        			$('#payaccountholder').textbox('enable');
        			$('#payvalidyyyymm').textbox('enable');	        			
        			$('#paycardapprovalno').textbox('enable');
        			$('#paycardapprovaldt').datebox('enable');	        			
        			$('#paycardreq').show();
        			
        			$('#paycashrcptgb').combobox('disable');
        			$('#paycashrcptgb').combobox('select', 'N');
        			$('#paycashrcptno').textbox('disable');
        			$('#paycashapprovalno').textbox('disable');
        			$('#paycashdreq').hide();
        			
        			$('#divPayCash').hide();
        			$('#divPayCard').show();
        			$('#divPayRefund').hide();
        			
        			//수납인 경우 카드정보 정보 바인딩.
        			if($("#payreceivegb").combobox('getValue') == 1){
        				if(g_jsonAccount.paymenttype == 2){
	        				$('#paybankcardcd').combogrid('setValue', g_jsonAccount.bankcardcd);
	        				$('#payaccountno').textbox('setValue', g_jsonAccount.accountno);
	        				$('#payaccountholder').textbox('setValue', g_jsonAccount.accountholder);
	        				$('#payresidentno').textbox('setValue', g_jsonAccount.residentno);
	        				$('#payvalidyyyymm').textbox('setValue', g_jsonAccount.validyyyymm);
        				}
        			}
        			
        		}else if (newVal == 5){ // 무통장
        			$('#paycashrcptgb').combobox('enable');
        			$('#paycashrcptgb').combobox('select', 'Y');
        			$('#paycashrcptno').textbox('disable');
        			$('#paycashapprovalno').textbox('disable');
        			$('#paycashdreq').hide();
        			
        			$('#paybankcardcd').combobox('disable');
        			$('#payaccountno').textbox('disable');
        			$('#payaccountholder').textbox('disable');
        			$('#payvalidyyyymm').textbox('disable');	        			
        			$('#paycardapprovalno').textbox('disable');
        			$('#paycardapprovaldt').datebox('disable');	        			
        			$('#paycardreq').hide();
        			
        			$('#divPayCash').show();
        			$('#divPayCard').hide();
        			
        			
        			//환불인 경우 은행계좌 정보 바인딩.
        			if($("#payreceivegb").combobox('getValue') == 2){
        				
        				if(g_jsonAccount.paymenttype == 1){
	        				$('#payrefundbankcd').combobox('select', g_jsonAccount.bankcardcd);
	        				$('#payrefundaccountno').textbox('setValue', g_jsonAccount.accountno);
	        				$('#payrefundaccountholder').textbox('setValue', g_jsonAccount.accountholder);
        				}
        				$('#divPayRefund').show();	
        			}
        		}
        		g_fitDlgSize('dlgPay');
        	} 
        });
        
        // 현금영수증신청여부선택
        $('#paycashrcptgb').combobox({
        	onChange : function (newVal, oldVal){	        		
        		//console.log(newVal)
        		if (newVal == 'N'){ // 신청안함
        			$('#paycashrcptno').textbox('disable');
        			$('#paycashapprovalno').textbox('disable');
        			$('#paycashdreq').hide();
        		}else{ // 신청함
        			$('#paycashrcptno').textbox('enable');
        			$('#paycashapprovalno').textbox('enable');
        			$('#paycashdreq').show();
        		}
        	} 
        });
        
        
        
        //////////////////////////////////////////
        // 상담
        //////////////////////////////////////////
        
        
        
   		
        // 상담 대분류 선택시
        
        $('#colargetype').combobox({
        	onChange : function (newVal, oldVal){

        		var joMiddleTypeList = getCounselMiddleTypeByLargeType(newVal);

        		$('#comiddletype').combobox({
        			valueField: 'code_id',
        			textField: 'code_name',
        			data: joMiddleTypeList
        		});
        	} 
        });
        
        // 상담중분류선택시
        $('#comiddletype').combobox({
        	onChange : function (newVal, oldVal){
        		var joSmallTypeList = getCounselSmallTypeByMiddleType(newVal);
        		$('#cosmalltype').combobox({
        			valueField: 'code_id',
        			textField:  'code_name',
        			data: joSmallTypeList
        		});
        	} 
        });
        
        var parentId = '1';
        
        var joItemDtl = getCounselMiddleTypeByLargeType(parentId);
        
        $('#comiddletype').combobox({
   			valueField: 'code_id',
   			textField: 'code_name',
   			data: joItemDtl
   		}); 
        
        $('#colargetype').combobox('select', '1'); // 기본적으로 하나선택
        
        
        
        $('#dgSmsContact').datagrid({
			title: 'SMS컨택',
			rownumbers: true,
			singleSelect: true,
			width: 200,
			height: 200,				
		    columns:[[
		        {field:'id',title:'아이디', hidden:true},
		        {field:'senddt',title:'발송일자'},
		        {field:'sendtime',title:'발송시간'},
		        {field:'sendmsg',title:'발송내용'}
		       
		        
		    ]],
			onClickRow : function(index, row){	        		        		
	        }
		});
        
        $('#dgSmsAbsent').datagrid({
			title: 'SMS부재',
			rownumbers: true,
			singleSelect: true,
			width: 200,
			height: 200,				
		    columns:[[
		        {field:'id',title:'아이디', hidden:true},
		        {field:'senddt',title:'발송일자'},
		        {field:'sendtime',title:'발송시간'},
		        {field:'sendmsg',title:'발송내용'}
		       
		        
		    ]],
			onClickRow : function(index, row){	        		        		
	        }
		});
        
       
        
        $('#dgTryCall').datagrid({
			title: '통화시도',
			rownumbers: true,
			singleSelect: true,
			width: 200,
			height: 200,				
		    columns:[[
		        {field:'id',title:'아이디', hidden:true},
		        {field:'calldt',title:'통화일자'},
		        {field:'callstrtime',title:'통화시도'},
		        {field:'callendtime',title:'통화종료'}
		       
		        
		    ]],
			onClickRow : function(index, row){	        		        		
	        }
		});
        
        $('#dgChgCareReqDt').datagrid({
			title: '예정일변경',
			rownumbers: true,
			singleSelect: true,
			width: 400,
			height: 200,				
		    columns:[[
		        {field:'id',title:'아이디', hidden:true},
		        {field:'service_turn',title:'회차'},
		        {field:'bfrdt',title:'변경전날짜'},
		        {field:'bfrtime',title:'변경전시간'},
		        {field:'aftdt',title:'변경후날짜'},
		        {field:'afttime',title:'변경후시간'},
		        {field:'changereason',title:'이유'},
		        {field:'enternm',title:'입력자'},
		        {field:'enterdt',title:'입력날짜'}
		        
		    ]],
			onClickRow : function(index, row){	        		        		
	        }
		});
       	           		
        initManagerCombo();
        
        var startOfMonth = moment().startOf('month').format('YYYY-MM-DD');
		var endOfMonth = moment().endOf('month').format('YYYY-MM-DD');
		
		$('#contactsdate').datebox('setValue', startOfMonth);
		$('#contactedate').datebox('setValue', endOfMonth);
        
        
			        
        initDgContractList(); // 멤버쉽 계약 그리드 초기화
        initDgGeneralContractList(); // 일반 계약 그리드 초기화
        
        initRecvUser(); // 계약탭/접수매니저
        initDgRecvList(); // 계약탭/접수초기화
        
        initTaskTransUser(); // 이관담당자초기화
        initDgPayContractList(); // 멤버쉽 수납 그리드 초기화
        initDgPayGeneralContractList(); // 일반 수납 그리드 초기화
        initDgPayTgContractList(); //통합수납그리드 초기화
        initPayBankCard();	        
        initDgCounsel();
        initSmsSendHistory();
        
        initAccountInfoHist();
        
        scheduleOrganComboLoading();
        
    }); // document ready end // eofdoc
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    function formatter2(date){
	    if (!date){return '';}
	    var y = date.getFullYear();
	    var m = date.getMonth() + 1;
	    return y + '-' + (m<10?('0'+m):m);
	}
	function parser2(s){
	    if (!s){return null;}
	    var ss = s.split('-');
	    var y = parseInt(ss[0],10);
	    var m = parseInt(ss[1],10);
	    if (!isNaN(y) && !isNaN(m)){
	        return new Date(y,m-1,1);
	    } else {
	        return new Date();
	    }
	}
    
    
    
    // 컨택정보 클리어
    function clearDgContactList(){
       	$('#dgSmsContact').datagrid('loadData', []); // SMS컨택
       	$('#dgSmsAbsent').datagrid('loadData', []); // SMS부재
       	$('#dgTryCall').datagrid('loadData', []); // 통화시도
       	$('#dgChgCareReqDt').datagrid('loadData', []); // 예정일변경
    }
    
    function isAdmin(){
		
		 var isAdmin = '${isAdmin}';
		 if (isEmpty(isAdmin)){
			 return false;
		 }
		 if (isAdmin == 'true'){
			 return true;
		 }
		 return false;
		 
	}
    
    // 관리자 혹은 상담사인지여부
	function isAC(){
		
		 var isAC = '${isAC}';
		 //console.log(isAC);
		 if (isEmpty(isAC)){
			 return false;
		 }
		 if (isAC == 'true'){
			 return true;
		 }
		 return false;
		 
	}
    
		
    function bankCardComboLoading(in_paymenttype) {
		
		var ccid = in_paymenttype == '1'? 'BANKCD': 'CARDCD';
		$('#acbankcardcd' ).combobox({
			valueField:'code_id',
			textField:'code_name',
			data: getBankCardCdByCodeClassId(ccid),
			onChange : function (newValue, oldValue){
				$('#acbankcardcddummy').textbox('setValue', newValue);					
			}
		});			
		return ;
		
	};

    // 고객정보 변경이력
    function searchCustInfoHist(){		
		
    	$('#dlgCustInfoHistory').dialog('open');
		$('#dgCustInfoHist').datagrid({
			title: '고객정보변경이력',
			rownumbers: true,
			singleSelect: true,
			width: 5000,
			height: 300,				
			url: '/customer/getCustInfoHistory.do',
			queryParams:{
				custid: g_custid
			},
			columns:[[
		        {field:'id',title:'아이디', hidden:true},
		        {field:'custid',title:'custid', hidden:true},
		        {field:'item',title:'항목'},
		        {field:'bfvalue',title:'변경전값'},		        
		        {field:'afvalue',title:'변경후값'},
		        {field:'enternm',title:'변경자'},
		        {field:'enterdt',title:'변경시간'}
		    ]]
		});
		        
	}
    
    
    // 고객등록창 초기화
    function initCustomerRegModal(){
    	$('#fmCustBasic').form('clear');
    }
    
    
    
	function doSearchCust(){
    	
    	var custnm = $('#sccustnm').textbox('getValue'); // 고객명
    	var custid = $('#sccustid').textbox('getValue'); // 고객아이디
    	var mobileno = $('#scmobileno').textbox('getValue'); // 휴대폰
    	var telno = $('#sctelno').textbox('getValue');	// 전화번호
    	var contractno = $('#sccontractno').textbox('getValue'); // 계약번호
    	var ordr_no = $('#scordr_no').textbox('getValue');		// 오더번호
    	
    	if (custnm == '' && custid == '' && mobileno == '' 
    		 && telno == '' && contractno == '' && ordr_no == '') {
    		alert('검색어를 입력해 주세요');
    		return;
    	}
    	
    	$('#dgCustomer').datagrid({
    		url: '/customer/getSearchCustomers.do',
    		method: 'get',
    		queryParams: {
         		  custnm: custnm
         		, custid: custid
         		, mobileno: mobileno
         		, telno: telno
         		, contractno: contractno
         		, ordr_no: ordr_no
    		}
    		
    	});
    }
	
	function doSearchProduct(){
		
		$('#dgProduct').datagrid({
    		url: '/customer/getAddProductHistory.do',
    		method: 'get',
    		queryParams: {
         
         		 contract_id:$("#history_contract_id").val()
         		
    		}
    		
    	});
	}
	
function doSearchContractHistory(){
		
		$('#dgProduct1').datagrid({
    		url: '/customer/getContractHistory.do',
    		method: 'get',
    		queryParams: {
         
         		 contract_id:$("#history_contract_id").val()
         		
    		}
    		
    	});
	}
	
	
    // 고객상세화면 초기화
    function initCustomerDetail(){
    	location.href = '/membershipManageDetailCustomer.do?custid=';
    }
    
    
    // 고객상세화면 갱신
	function refreshCustomerDetail(){
		//location.href = '/membershipManageDetailCustomer.do?custid=' + g_custid;
		getCustInfo(g_custid);
    }
    
	// 고객용 컨텐츠 클리어
    function clearSmsContent(){
    	 $('#cssmscontent').textbox('setValue', '');
    	 $('#cssmslength').text('0');
    }
    
    // 매니저용 컨텐츠 클리어
    function clearManagerSmsContent(){
	   	 $('#mssmscontent').textbox('setValue', '');
	   	 $('#mssmslength').text('0');
   	}
    
    function initSmsSendHistory(){
    	$('#dgSmsSendHistory').datagrid({
			title: 'SMS이력',
			rownumbers: true,
			singleSelect: true,
			fitColumns: true,
			width: 500,
			height: 200,
			
		    columns:[[
		    	{field:'mobileno',title:'휴대폰'},
		        {field:'content',title:'내용' },
		        {field:'usernm',title:'보낸사람'},
		        {field:'enterdt',title:'날짜'}
		    	]]
    	});
    }
    // 고객 SMS 팝업
    function openCustomerSmsModal(){
    	$('#fmCustomerSms').form('clear');
    	var custnm = $('#gmcustnm').textbox('getValue');
    	var mobileno = $('#gmmobileno').textbox('getValue');
    	mobileno = mobileno.replace(/-/gi, ""); 
    	$('#cscustnm').textbox('setValue',custnm );
    	$('#csmobileno').textbox('setValue', mobileno);
    	
    	var t = $('#cssmscontent');
    	t.textbox('textbox').bind('keyup', function(e){
    		
    		
			var content = $(this).val();
			
			var contentByteLength = getByteLength(content);
			
			if (contentByteLength > g_maxTextLength ){
				content = cutByteLength(content, g_maxTextLength);
				t.textbox('setValue', content);
			}
			
			$('#cssmslength').text(contentByteLength);
    	});
    	$('#dgSmsSendHistory').datagrid('loadData', []);
 		$('#dlgCustomerSms').dialog('open');
    }
    
    // 매니저 SMS 팝업
    // [in] managerMobileNo: - 없는 번호
    function openManagerSmsModal(managerId, managerName, managerMobileNo, prodGroupName, careReqDt, careReqTime){
    	$('#fmManagerSms').form('clear');
    	var mobileno = managerMobileNo;
    	mobileno = mobileno.replace(/-/gi, ""); 
    	$('#msmanagerid').val(managerId);
    	$('#msmanagernm').textbox('setValue',managerName );
    	$('#msmobileno').textbox('setValue', mobileno);
    	$('#msprodgroupnm').textbox('setValue', prodGroupName);
    	$('#mscarereqdt').textbox('setValue', careReqDt);
    	$('#mscarereqtime').textbox('setValue', careReqTime);
    	
    	var t = $('#mssmscontent');
    	t.textbox('textbox').bind('keyup', function(e){
    		
    		
			var content = $(this).val();
			var contentByteLength = getByteLength(content);
			
			if (contentByteLength > g_maxTextLength ){
				//content = content.substring(0, g_maxTextLength);
				content = cutByteLength(content, g_maxTextLength);
				t.textbox('setValue', content);
			}
			
			//$('#mssmslength').text(content.length);
			$('#mssmslength').text(contentByteLength);
    	});
    	
 		$('#dlgManagerSms').dialog('open');
    }
    
    // 고객검색팝업
	function openSearchCustomerModal(){
 		$('#dlgSearchCust').dialog('open');
    }
    
	function openProductHistory(){
 		$('#dlgSearchProduct').dialog('open');
 		doSearchProduct();
    }
	
	
	function openContractHistory(){
 		$('#dlgSearchContract').dialog('open');
 		doSearchContractHistory();
    }
    function newCustomer(){
    	initCustomerRegModal();
    	$('#baioru').val('I');
    	$('#dlgCustBasic').dialog('open');
    	$('#btnGoInit').show();
    }
    
 	// 고객수정팝업
    function editCustomer(){
    	var row = new Object();
    	$('#baioru').val('U');
    	
    	row.custnm = $('#gmcustnm').val();
    	row.custid = $('#gmcustid').val();
    	row.id = $('#gmid').val();
    	row.mobileno1 = $('#gmmobileno1').val();
    	row.mobileno2 = $('#gmmobileno2').val();
    	row.mobileno3 = $('#gmmobileno3').val();
    	row.telno1 = $('#gmtelno1').val();
    	row.telno2 = $('#gmtelno2').val();
    	row.telno3 = $('#gmtelno3').val();
    	row.juminno1 = $('#gmjuminno1').val();
    	
    	row.zipcd = $('#gmzipcd').val();
    	row.addr1 = $('#gmaddr1').val();
    	row.addr2 = $('#gmaddr2').val();
    	row.remarks = $('#gmremarks').val();
    	
    	$('#fmCustBasic').form('load', row);
 		$('#dlgCustBasic').dialog('open');
 		$('#btnGoInit').hide();
 		
    }
    
    function viewManagerSchedule(){
   	   var where = $('#mgswhere').val();
   	   var managerid, yearmonth, organcd;
   	   if (where == 'R'){ 
   		   // 회차
   		   managerid = $("#recvmanager_id").combobox('getValue');
   	   	   yearmonth = getThisYearMonth().replace(/-/gi, "");
   	   	   organcd = $('#recvcareorgancd').textbox('getValue');
   	   	   
   	   	    
   	   	   
   	   }else if (where == 'C1'){
   		   // 계약
			managerid = $("#newcontractadd_manager_id1").combobox('getValue');
   	   	  	yearmonth = $('#newcontractcarereqdt').datebox('getValue').replace(/-/gi, "");
   	   	  	organcd = $('#newcontractrcptorgancd1').combobox('getValue');
   	   		if (yearmonth != null && yearmonth.length == 8){
				var cyyyy = yearmonth.substring(0,4);
				var cmm = yearmonth.substring(4,6);
				var cdd = yearmonth.substring(6,8);
				yearmonth = cyyyy + cmm;
			}
   	   }else if (where == 'C'){
   			// 계약
			managerid = $("#newcontractmanager_id").combobox('getValue');
   	   	  	yearmonth = $('#newcontractcarereqdt').datebox('getValue').replace(/-/gi, "");
   	   	 	organcd = $('#newcontractrcptorgancd').combobox('getValue');
   	   		if (yearmonth != null && yearmonth.length == 8){
				var cyyyy = yearmonth.substring(0,4);
				var cmm = yearmonth.substring(4,6);
				var cdd = yearmonth.substring(6,8);
				yearmonth = cyyyy + cmm;
			}
   	   }else{
   		   return;
   	   }
   	   
    	
			
    	getManagerScheduleInfo(managerid, organcd, yearmonth);
    	   
    	   
    	   
    }
    
    // 매니저스케줄검색
    function searchManagerSchedule(){
    	var managerid , organcd, yearmonth;
    	managerid = $('#schmanager_id').combobox('getValue');
    	organcd = $('#schrcptorgancd').combobox('getValue');
    	yearmonth = $('#schyearmonth').datetimespinner('getValue');
    	yearmonth = yearmonth.replace(/-/gi, "");
    	
    	getManagerScheduleInfo(managerid, organcd, yearmonth);
    }
    
    // 매니저 스케줄 정보 가져오기
    // [IN] managerid, organcd, yearmonth
    function getManagerScheduleInfo(managerid, organcd, yearmonth){
    	
    	// 스케줄 모달을 띄울 때 미리 설정하기
		$('#schrcptorgancd').combobox('setValue', organcd);
		$('#schmanager_id').combobox('setValue', managerid);				
		var year_mm = yearmonth.substring(0,4) + '-' + yearmonth.substring(4,6);
		$('#schyearmonth').datetimespinner('setValue', year_mm);
		
    	$.ajax({
			url : "/customer/getManagerSchedulList.do",
			type : "POST",
			dataType : "json",
			data: {
				manager_id : managerid, yearmonth : yearmonth
			},
			success : function(response){
				
				$('#dlgMgSchedule').dialog('open').dialog('center').dialog('setTitle','스케줄조회');				
				$('#dgMgSchedue').datagrid('loadData', []);
				$('#dgMgSchedueDetail').datagrid('loadData', []);
				
				// 데이터 타이밍 문제로 인해 schrcptorgancd를 상단에서 먼저 설정 후 다음을 후출한다. 
				//$('#schmanager_id').combobox('setValue', managerid);				
				//var year_mm = yearmonth.substring(0,4) + '-' + yearmonth.substring(4,6);
				//$('#schyearmonth').datetimespinner('setValue', year_mm);
				
				if(isAC() == true){ // 관리자, 상담사인 경우
	    		   $('#schrcptorgancd').combobox('readonly', false);
	    	   	}else{ // 관리자, 상담사가 아닌 경우 조회하는 기관 정보 수정할 수 없다. 
	    		   $('#schrcptorgancd').combobox('readonly', true);
	    	   	}
				
				var list = response.list;
				if (list == null){
					alert('스케쥴 정보가 없습니다')
					return;
				}						
				if(list != null && list.length > 0) {
					$.each(list, function(idx, obj) {
						$('#dgMgSchedue').datagrid('appendRow', obj);
					});
				}						
			},
			error: function(xhr, status, thrown) {
				if(xhr != undefined && xhr.status == 500){}
				else {}
			},
			complete :function(){}
		});
    }
		
    function saveCounsel(){
    	var url =  '/customer/saveCounsel.do';
	    $('#fmCustCounsel').form('submit',{
	        url: url,
	        onSubmit: function(){
	        	
	        	if(isEmpty($('#comiddletype').combobox('getValue'))){
	        		alert('통화유형 중분류를 선택해주세요');
	        		return false;
	        	}
	        			        	
	        	if(isEmpty($('#cosmalltype').combobox('getValue'))){	alert('통화유형 소분류를 선택해주세요');return false;}
	        	
	        	var contentslen = $('#cocontents').textbox('getValue').length;		        	
	        	if (contentslen <= 9){
	        		alert('통화내용은 10자이상 입력을 해야 합니다.');
	        		return false;
	        	}
	        	
	            return $(this).form('validate');
	        },
	        success: function(result){
	            var result = eval('('+result+')');
	            if (result.errorMsg){
	                $.messager.show({
	                    title: 'Error',
	                    msg: result.errorMsg
	                });
	            } else {
	                //$('#dgCounsel').datagrid('reload');
	            	getDgCounsel();
	            }
	            enableBtnSaveCounsel(false);
	        }
	    });
	}
	    
    function saveCustomer(){
       	
    	var url =  '/customer/saveCustomer.do';
	    $('#fmCustBasic').form('submit',{
	        url: url,
	        onSubmit: function(){
	        	
	        	if (false == $('#fmCustBasic').form('validate')){
	    			alert('필수 정보를 입력해 주십시오.');
	    			return false;
	    		}
	        	
	        	//이름 최대 10
	        	if($("#bacustnm").textbox("getValue").length > 10){
	        		alert("이름은 10자 이하로 입력하시기 바랍니다.");
	        		return false;
	        	}
	        	
	        	//모바일 최대 4
	        	if($("#bamobileno1").textbox("getValue").length > 4){
	        		alert("휴대폰 첫번째 최대 4자리 입니다.");
	        		return false;
	        	}
	        	
	        	if($("#bamobileno2").textbox("getValue").length > 4){
	        		alert("휴대폰 두번째 최대 4자리 입니다.");
	        		return false;
	        	}
	        	
	        	if($("#bamobileno3").textbox("getValue").length > 4){
	        		alert("휴대폰 세번째 최대 4자리 입니다.");
	        		return false;
	        	}
	       
	        	if($("#batelno1").textbox("getValue").length > 4){
	        		alert("전화번호 첫번째 최대 4자리 입니다.");
	        		return false;
	        	}
	        	
	        	if($("#batelno2").textbox("getValue").length > 4){
	        		alert("전화번호 두번째 최대 4자리 입니다.");
	        		return false;
	        	}
	        	
	        	if($("#batelno3").textbox("getValue").length > 4){
	        		alert("전화번호 세번째 최대 4자리 입니다.");
	        		return false;
	        	}
	        	
	  
	        	if($("#baaddr1").textbox("getValue").length > 100){
	        		alert("주소1 100자 이하로 입력하시기 바랍니다.");
	        		return false;
	        	}
	        	
	        	if($("#baaddr2").textbox("getValue").length > 100){
	        		alert("주소2 100자 이하로 입력하시기 바랍니다.");
	        		return false;
	        	}
	    
	        	
	        	//비고 100자리 
	        	if($("#baremarks").textbox("getValue").length > 100){
	        		alert("비고 100자 이하로 입력하시기 바랍니다.");
	        		return false;
	        	}
	        	
	            return $(this).form('validate');
	        },
	        success: function(result){
	            var result = eval('('+result+')');
	            console.log(result)
	            if (result.errorMsg){
	            	
	            	alert('고객정보 저장시 에러 발생했습니다.' + result.errorMsg);
	                
	            } else {
	            	
	            	// 신규고객저장인 경우 
	            	if (isEmpty($('#baioru').val()) || $('#baioru').val() == 'I'){
	            		var custid = result.custid;
	            		
	            		getCustInfo(custid);
	            		initCustomerRegModal();
	            		$('#dlgCustBasic').dialog('close');
	            		return;
	            	}else{
	            	
	            		// 고객정보업데이트인경우
		            	$('#gmmobileno').textbox( 'setValue'
	                			, $('#bamobileno1').val() + '-' +  $('#bamobileno2').val() + '-' + $('#bamobileno3').val());
		                $('#gmtelno').textbox( 'setValue'
		                			, $('#batelno1').val() + '-' +  $('#batelno2').val() + '-' + $('#batelno3').val());
		                $('#gmaddr').textbox( 'setValue'
	                			, $('#baaddr1').val() + '/' +  $('#baaddr2').val() );
		                
		              	$('#gmbobileno1').val( $('#bamobileno1').val() );
		              	$('#gmbobileno2').val( $('#bamobileno2').val() );
		              	$('#gmbobileno3').val( $('#bamobileno3').val() );
		              	$('#gmtelno1').val( $('#batelno1').val() );
		              	$('#gmtelno2').val( $('#batelno2').val() );
		              	$('#gmtelno3').val( $('#batelno3').val() );
		              	$('#gmjuminno1').val( $('#bajuminno1').val() );
		            	
		              	$('#gmzipcd').val( $('#bazipcd').val() );
		              	$('#gmaddr1').val( $('#baaddr1').val() );
		              	$('#gmaddr2').val( $('#baaddr2').val() );
		              	$('#gmremarks').val( $('#baremarks').val() );
	              	
		                alert('고객정보를 저장했습니다');
		                $('#dlgCustBasic').dialog('close')
	            	}
	            	
	            			                
	                
	            }
	        }
	    });
	}
	    
	
	    // 이관담당자 초기화
	    function initTaskTransUser(){
	    	$('#cotakeuserid').combogrid({
	    	    panelWidth:500,
	    	    url: '/customer/getSaleUser.do',
	    	    idField:'userid',
	    	    textField:'usernm',
	    	    mode:'remote',
	    	    fitColumns:true,
	    	    columns:[[
	    	        {field:'userid',title:'ID',width:60},
	    	        {field:'usernm',title:'사용자명',align:'right',width:80},
	    	        {field:'organcd',title:'기관코드',align:'right',width:60},
	    	        {field:'organnm',title:'기관명',align:'right',width:60},
	    	        {field:'mobileno',title:'휴대폰',align:'right',width:60, hidden: true}
	    	    ]],
	    	    onSelect : function (index, row){
	    	    	$('#cotakeorgancd').val(row.organcd);
	    	    }
	    	});
	    }
	    
	    // 상담정보입력 폼 clear
	    function initFormCounsel(customer){
	   		// fmCustCounsel
	   		
	   		$('#cocustid').val(customer.custid);
	   		$('#comobileno1').val(customer.mobileno1);
	   		$('#comobileno2').val(customer.mobileno2);
	   		$('#comobileno3').val(customer.mobileno3);
	   		$('#cotelno1').val(customer.telno1);
	   		$('#cotelno2').val(customer.telno2);
	   		$('#cotelno3').val(customer.telno3);
	   		$('#cotaskgb').combobox('setValue', '1');
	   		$('#cotransgb').combobox('setValue', '1');
	   		$('#cocallgb').combobox('setValue', '1');
	   		$('#colargetype').combobox('setValue', '1');
	   		$('#comiddletype').combobox('setValue', '');
	   		$('#cosmalltype').combobox('setValue', '');
	   		$('#coupdateid').val('');
	   		$('#coupdatenm').textbox('setValue', '');
	   		
	   		$('#cotakeorgancd').val('');
	   		$('#cotakeuserid').combobox('setValue', '');
	   		$('#cotransdt').datebox('setValue', '');
	   		$('#cotranstime').timespinner('clear');
	   		$('#calldt').datebox('clear');
	   		$('#callstart').timespinner('clear');
	   		$('#callend').timespinner('clear');
	   		$('#cocontents').textbox('setValue', '');
	   		
	    }
	    
	    function getDgCounsel(){
	    	/*
	    	$('#dgCounsel').datagrid({
	  			url: '/customer/getCounselList.do',
				queryParams:{
					custid: g_custid
				}
			});
	    	*/
	    	
	    	$.ajax({
	  			url : "/customer/getCounselList.do",
	  			type : "POST",
	  			dataType : "json",
	  			data: {
	  				custid: g_custid
	  			},
	  			success : function(response){
	  				if (response.rows != null){
	  					$('#dgCounsel').datagrid({data: response.rows});  
	  				}else{
	  					$('#dgCounsel').datagrid('loadData', []);  
	  				}
	  			},
	  			error: function(xhr, status, thrown) {
	  				
	  				console.log('상담정보수신시 에러 발생')
	  			},
	  			complete :function(){		
	  				
	  			}
	  		});
	    }
	    
	    function initDgCounsel(){
	    	$('#dgCounsel').datagrid({
				title: '상담정보',
				rownumbers: true,
				singleSelect: true,
				toolbar : '#toolbar-counsel',				
				width: 1000,
				height: 250,
				//url: '/customer/getCounselList.do',
				//queryParams:{
				//	custid: g_custid
				//},
			    columns:[[
			        {field:'id',title:'아이디', hidden:true},
			        {field:'custid',title:'고객아이디', hidden:true},
			        {field:'custnm',title:'고객명', hidden:true},
			        {field:'calldt',title:'통화일자', formatter: dataGridFormatDate},
			        {field:'callstart',title:'통화시작', hidden:true},
			        {field:'callend',title:'통화종료', hidden:true},
			        {field:'callgb',title:'통화구분cd', hidden:true},
			        {field:'callgb_',title:'통화구분', hidden:true},
			        
			        {field:'transgb',title:'송신자cd', hidden:true},
			        {field:'transgb_',title:'송신자', hidden:true },
			        
			        {field:'largetype',title:'통화유형1cd', hidden:true},
			        {field:'largetype_',title:'통화유형1', hidden:true},
			        {field:'middletype',title:'통화유형cd2', hidden:true},
			        {field:'middletype_',title:'통화유형2'},
			        {field:'smalltype',title:'통화유형3cd', hidden:true},			        
			        {field:'smalltype_',title:'통화유형3'},
			        {field:'taskgb',title:'업무구분cd', hidden:true},
			        {field:'taskgb_',title:'업무구분'},
			        {field:'updateid',title:'통화자명cd', hidden:true},
			        {field:'updatenm',title:'통화자명'},
			        {field:'contents',title:'내용'},
			        {field:'enterdt_',title:'생성일자'},
			        {field:'updatedt_',title:'수정일자'},
			        {field:'takeuserid',title:'이관자id', hidden:true},
			        {field:'takeusernm',title:'이관자명', hidden:true}
			        
			        			        
			    ]],
				onClickRow : function(index, row){
					
					if (row ) {
						
						enableBtnSaveCounsel(false); // when grid click disable button
						
						// copy obj
						var nrow = $.extend({}, row);
						
						nrow.calldt = getEasyUiDateFromString(nrow.calldt);
						nrow.callstart = getEasyUiTimeFromString(nrow.callstart);
						nrow.callend = getEasyUiTimeFromString(nrow.callend);
						
						//console.log(nrow.calldt)
						//console.log(nrow.callstart)
						//console.log(nrow.callend )
						
						var srtRow = {};
						Object.keys(nrow).sort().forEach(function(key) {
							srtRow[key] = nrow[key];
						});
						
// 						$('#fmCustCounsel').form('load',nrow);
						$('#fmCustCounsel').form('load',srtRow);
						$('#cotakeuserid').combogrid('setValue',{userid: nrow.takeuserid, usernm: nrow.takeusernm});
						
					}
				} // e.onClickRow
			});
	    }
	    
	    
	    
	    function enableBtnSaveCounsel(enable){
	    	if (enable == true){
	    		$('#btnSaveCounsel').linkbutton('enable');
	    	}else{
	    		$('#btnSaveCounsel').linkbutton('disable');
	    	}
	    		
	    }
	    
	    function newCounsel(){
	    	
            $('#cosaleorgancd').val($('#contractsaleorgancd').val());
            $('#cosaleyear').val($('#contractsaleyear').val());
			$('#coseqno').val($('#contractseqno').val());
			$('#coupdateid').val('${loginInfo.user_id}');
			$('#coupdatenm').textbox('setValue', '${loginInfo.user_name}');
	    	
	    	enableBtnSaveCounsel(true);
	    
	    	var today = getToday();
	    	var callstart = moment().format('HH:mm');
	    	var callend =  moment().add(5, 'minutes').format('HH:mm');	    	
	    	$('#calldt').datebox('setValue', today);	    	
	    	$("#callstart").timespinner('setValue', callstart);
	    	$("#callend").timespinner('setValue', callend);
	    	
	    	$('#cotakeuserid').combobox('setValue', ''); 
	    	$('#cotransdt').datebox('setValue', today);	    	
	    	$("#cotranstime").timespinner('setValue', callstart);
	    	
	    	
	    	$('#cocounselid').val('');
	    	$('#cocontents').textbox('setValue', '');	    	
	    	$('#cotaskgb').combobox('setValue', '2'); // 처리로 기본선택
	    	$('#cotransgb').combobox('setValue', '1'); 
	    	$('#cocallgb').combobox('setValue', '1');
	    	 
	    	$('#comiddletype').combobox('setValue', ''); 
	    	$('#cosmalltype').combobox('setValue', '');
	    	$('#colargetype').combobox('select', '1');
	    
	    	$('#cotakeorgancd').val('');
			$('#cotakeuserid').combobox('setValue','');
			$('#cotransdt').datebox('setValue', '');
			$('#cotranstime').timespinner('setValue', '');
	    	
	    }
        
	    function editCounsel(){
	    	
	    	var isToday = false;
	    	var row = $('#dgCounsel').datagrid('getSelected');
	    	

	    	if (row ) {
	    		var nrow = $.extend({}, row);
				$('#fmCustCounsel').form('load',nrow);
				if (getTodayYYYYMMDD() == nrow.updatedt_){
					isToday = true;
				}
				
				if (isToday != true){
		    		alert('수정은 당일만 가능합니다');
		    		return;
		    	}
		    	enableBtnSaveCounsel(true);
		    	
		    	var callstart = moment().format('HH:mm');
		    	var callend =  moment().add(5, 'minutes').format('HH:mm');
		    	$("#callstart").timespinner('setValue', callstart);
		    	$("#callend").timespinner('setValue', callend);
		    	
		    	$('#cotakeuserid').combogrid('setValue',{userid: nrow.takeuserid, usernm: nrow.takeusernm});
		    	
		    	$('#coupdateid').val('${loginInfo.user_id}');
		    	$('#coupdatenm').val('${loginInfo.user_name}');
			}
	    	
	    }
</script>