<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">

	
	// 해지예정저장
	function saveReserveCloseDt(){
		
		var reserveclosedt = $('clreserveclosedt').datebox('getValue');
		var saleorgancd ;
		var saleyear;
		var seqno;
		
		$.ajax({
			url : "/customer/saveReserveCloseDt.do",
			type : "POST",
			dataType : "json",
			data : {
				  reserveclosedt : reserveclosedt
				, saleorgancd : saleorgancd
				, saleyear: saleyear
				, seqno : seqno
			},
			success : function(data){
				alert('해지예정일을 저장했습니다');
				
			},
			error: function(xhr, status, thrown) {
				alert('해지 예정일을 저장하는데 실패했습니다');
			},
			complete :function(){
			}
		});
	}
	
	//매니저스케줄상세
	function getManagerScheduleDetail(row){
		$('#dgMgSchedueDetail').datagrid('loadData', []);
		
	   var where = $('#mgswhere').val();
 	   var managerid, yearmonthday;
 	   if (where == 'R'){ 
 		   // 회차
 		   managerid = $("#recvmanager_id").combobox('getValue');
 		  yearmonthday = getThisYearMonth().replace(/-/gi, "") + row.dt;   
 	   }else{
 		   // 계약
 		    managerid = $("#newcontractmanager_id").combobox('getValue');
 			yearmonthday = $('#newcontractcarereqdt').datebox('getValue').replace(/-/gi, "");
 			if (yearmonthday != null && yearmonthday.length == 8){
 				var cyyyy = yearmonthday.substring(0,4);
 				var cmm = yearmonthday.substring(4,6);
 				yearmonthday = cyyyy + cmm +  row.dt;
 			}
 	   }
		$.ajax({
			url : "/customer/getManagerSchedulDetailList.do",
			type : "POST",
			dataType : "json",
			data : {
				manager_id : managerid, yearmonthday : yearmonthday
			},
			success : function(data){
				
				
				if(data.list != null && data.list.length > 0) {
					$.each(data.list, function(idx, obj) {
						$('#dgMgSchedueDetail').datagrid('appendRow', obj);
					});
				}
			},
			error: function(xhr, status, thrown) {
			},
			complete :function(){
			}
		});
	}
	
	function initManagerCombo(){
		organComboLoading("newcontractsaleorgancd");
		organComboLoading("newcontractrcptorgancd");
		organComboLoading("newcontractrcptorgancd1");
		organComboLoading("newcontractrcptorgancd2");
		// 21. 12. 9
		organComboLoading("changeCareOrg_careorgancd");
	}
	
	// s. 매니저 스케줄 조회를 위한 기관 및 매니저 설정
	
	// 기관로딩
	function scheduleOrganComboLoading() {
		
		$('#schrcptorgancd').combobox({
			url:'/code/getOrgListNotAll.do',
			queryParams : {
				organkind:'4',
				optype:'4'
			},
			valueField:'organcd',
			textField:'organnm',
			onChange : function (newValue, oldValue){
				sheduleManagerComboLoading();
			},
			loadFilter: function(data) {
				//careorg ancd
				if ("${sessionScope.loginInfo.usertype}" == '1' || "${sessionScope.loginInfo.usertype}" == '2') {
					//careorgancd
					var opts = $(this).combobox('options');
			        var emptyRow = {};
			        emptyRow[opts.valueField] = '';
			        emptyRow[opts.textField] = '전체';
			        data.unshift(emptyRow);
				}
				return data;
			},
			onLoadSuccess: function(){
				
				if ("${sessionScope.loginInfo.usertype}" == '1' || "${sessionScope.loginInfo.usertype}" == '2') {
					$('#schrcptorgancd').combobox('select', '');
				} else {
					var data = $(this).combobox('getData');
					$('#schrcptorgancd').combobox('select', data[0].organcd);
				}
			}
		});
		
	};
	
	// 기관에 따른 매니저 로딩
	function sheduleManagerComboLoading() {
		$('#schmanager_id').combobox({
			url:'/code/getUserInfoCode.do',
			queryParams : {organcd : $("#schrcptorgancd").combobox('getValue')},
			valueField:'code_id',
			textField:'code_name',
			onChange : function (newValue, oldValue){
			}
		});
	};
	
	// e.
	
	// 로그인한 사용자에 따른 판매기관 및 판매자 설정
	function getSaleOrgAndSaleUser() {
		
	
		var org_combo_id = 'newcontractsaleorgancd';
		
		if ("${sessionScope.loginInfo.usertype}" == '1' ) {
			
			$('#' + org_combo_id).combobox('select', '');
			var manager_combo_id = g_orgManagerIdMap.get(org_combo_id);
			$('#' + manager_combo_id).combobox('select', '');
		} else if ("${sessionScope.loginInfo.usertype}" == '2'){
			
			var data = $('#' + org_combo_id).combobox('getData');
			var loginOrganCd = "${sessionScope.loginInfo.organcd}";
			var loginUserId  = "${sessionScope.loginInfo.user_id}";
			var manager_combo_id = g_orgManagerIdMap.get(org_combo_id);
			$('#' + org_combo_id).combobox('select', loginOrganCd);						
			$('#' + manager_combo_id).combobox('select', loginUserId);
		
		} else {
		
			var data = $('#' + org_combo_id).combobox('getData');
			var manager_combo_id = g_orgManagerIdMap.get(org_combo_id);
			var loginUserId  = "${sessionScope.loginInfo.user_id}";
			$('#' + org_combo_id).combobox('select', data[0].organcd);			
			$('#' + manager_combo_id).combobox('select', loginUserId);
		}
	}
	
	// 고객주소에 따른 매니저할당
	function getCareOrgAndManager(){
		var zipcd = $('#gmzipcd').val();
		var prodgroup = $('#newcontractprodgroup').combobox('getValue');			
		
		$.ajax({
			url : "/code/getCareOrgNManager.do",
			type : "POST",
			dataType : "json",
			data: {
				zipcd: zipcd,
				prodgroup: prodgroup
			},
			success : function(response){
				var result = response.result;
				//console.log(result);
				if (result == null){
					return;
				}
				
				var careorgancd =   result.careorgancd;
				var careorgannm =   result.careorgannm;
				var manager_id =  	result.manager_id;
				var manager_nm = 	result.manager_nm;
				
				$('#newcontractrcptorgancd').combobox('setValue', careorgancd);
				$('#newcontractmanager_id').combobox('setValue', manager_id);
				
			},
			error: function(xhr, status, thrown) {
				
				if(xhr != undefined && xhr.status == 500){
				}
				else {
				}
			},
			complete :function(){		
				
			}
		});
	}
    
  	//create a map
    var g_orgManagerIdMap = new Map();

    //add three keys & values to the map
    g_orgManagerIdMap.set("newcontractsaleorgancd", "newcontractsaleuserid");
    g_orgManagerIdMap.set("newcontractrcptorgancd", "newcontractmanager_id");
    g_orgManagerIdMap.set("newcontractrcptorgancd1", "newcontractadd_manager_id1");
    g_orgManagerIdMap.set("newcontractrcptorgancd2", "newcontractadd_manager_id2");
    //g_orgManagerIdMap.set("schrcptorgancd", "schmanager_id");
    g_orgManagerIdMap.set("changeCareOrg_careorgancd", "changeCareOrg_manager_id");
	
    
	
	function organComboLoading(org_combo_id) {
    	
		$('#' + org_combo_id ).combobox({
			
			valueField:'organcd',
			textField:'organnm',
			data: g_orgList,
			onChange : function (newValue, oldValue){
				managerComboLoading(org_combo_id);
			},
			onLoadSuccess: function(){
				
			}
		});
	};
	
	
	
	function managerComboLoading(org_combo_id) {
		
		var manager_combo_id = g_orgManagerIdMap.get(org_combo_id);		
		$('#' + manager_combo_id).combobox({
			url:'/code/getUserInfo.do',
			queryParams : {organcd : $('#' + org_combo_id).combobox('getValue')},
			valueField:'userid',
			textField:'usernm',
			onChange : function (newValue, oldValue){
				
			}
		});
	};
	
	
	
	// 서비스 특이사항 보기
	
    function openDlgServiceRemarks(remarks){						
		$('#dlgServiceRemarks').dialog('open').dialog('center').dialog('setTitle','특이사항');
		$('#serviceremarks').textbox('setValue' , remarks);			
	}
	// 서비스결과 사진보기
	function openDlgServiceResult(saleorgancd, saleyear, seqno, service_turn){
		var url = '/serviceAsServiceResult.do?saleorgancd={0}&saleyear={1}&seqno={2}&service_turn={3}'.format(saleorgancd, saleyear, seqno, service_turn);
		gfn_showModalWindowCust(url, null, 800, 1000, 140, 100);
	}
    
	// 컨택정보 조회
	function searchContact(){
    	
    	// dgSmsContact
    	// dgSmsAbsent
    	// dgTryCall
    	// dgChgCareReqDt
    	
		var saleorgancd = $('#contractsaleorgancd').val();
		var saleyear = $('#contractsaleyear').val();
		var seqno = $('#contractseqno').val();

		if(isEmpty(saleorgancd)){
			alert('계약을 선택해 주세요');
			return;
		}
    	
    	var sdate = $('#contactsdate').datebox('getValue');
    	var edate = $('#contactedate').datebox('getValue');
    	
    	$('#dgSmsContact').datagrid({
    		url: '/customer/getSmsContact.do',
    		queryParams:{
    			saleorgancd : saleorgancd,
    			saleyear: saleyear,
    			seqno: seqno,
    			sdate: sdate,
    			edate: edate
    		},
    	});
    	
    	$('#dgSmsAbsent').datagrid({
    		url: '/customer/getSmsAbsent.do',
    		queryParams:{
    			saleorgancd : saleorgancd,
    			saleyear: saleyear,
    			seqno: seqno,
    			sdate: sdate,
    			edate: edate
    		},
    	});
    	
    	$('#dgTryCall').datagrid({
    		url: '/customer/getTryCall.do',
    		queryParams:{
    			saleorgancd : saleorgancd,
    			saleyear: saleyear,
    			seqno: seqno,
    			sdate: sdate,
    			edate: edate
    		},
    	});
    	
    	$('#dgChgCareReqDt').datagrid({
    		url: '/customer/getChgCareReqDt.do',
    		queryParams:{
    			saleorgancd : saleorgancd,
    			saleyear: saleyear,
    			seqno: seqno,
    			sdate: sdate,
    			edate: edate
    		},
    	});
    	
    	
    }
	
	
	// 계약서 사진 보기
	function openDlgContractImageView(file_url){
		fileImagePopup(file_url);
    }
   

	// 계약의 패턴에 따른 서비스가능 코드 가져오기
	function serviceNmComboLoading(select){
		
		var pt_code = $('#contractpt_code').val();
		$('#recvservice_type_cd' ).combobox({
			url:'/code/getServiceCdList.do',
			queryParams : {pt_code: pt_code},
			valueField:'service_type_cd',
			textField:'service_type_nm',
			onChange : function (newValue, oldValue){
			},
			onLoadSuccess : function(data){
				/* reference
				if (select != null){
					console.log('not null')
					$(this).combobox('select', select);
				}
				*/
			}
		});
	}
	
	function getCareOrgAndManagerRecv(){
		var zipcd = $('#contractzipcd').val();
		var prodgroup = $('#contractprodgroup').val();
		
		//console.log('zipcd:' + zipcd + '/' + 'prodgroup:' + prodgroup); 
		
		$.ajax({
			url : "/code/getCareOrgNManager.do",
			type : "POST",
			dataType : "json",
			data: {
				zipcd: zipcd,
				prodgroup: prodgroup
			},
			success : function(response){
				var result = response.result;
				
				if (result == null){
					return;
				}
				
				var careorgancd =   result.careorgancd;
				var careorgannm =   result.careorgannm;
				var manager_id =  	result.manager_id;
				var manager_nm = 	result.manager_nm;
				
				$('#recvcareorgancd').textbox('setValue', careorgancd);
				$('#recvcareorgannm').textbox('setValue', careorgannm);
				$('#recvmanager_id').combogrid('setValue', {userid:manager_id, usernm: manager_nm});
				
				
			},
			error: function(xhr, status, thrown) {
				
				if(xhr != undefined && xhr.status == 500){
				}
				else {
				}
			},
			complete :function(){		
				
			}
		});
	}
	
	// where: R: 회차팝업 C: 계약팝업
	function getAreaRemarks(azipcd, aprodgroup, where){
		//var zipcd = $('#contractzipcd').val();
		//var prodgroup = $('#contractprodgroup').val();
		var zipcd = azipcd;
		var prodgroup = aprodgroup;
		
		$.ajax({
			url : "/code/getAreaRemarks.do",
			type : "POST",
			dataType : "json",
			data: {
				zipcd: zipcd,
				prodgroup: prodgroup
			},
			success : function(response){
				var result = response.result;
				
				if (result == null){
					return;
				}
				
				var area_remarks =   result.area_remarks;			
				if (where == 'R'){
					$('#recvarea_remarks').textbox('setValue', area_remarks);	
				}else{
					$('#newcontractarea_remarks').textbox('setValue', area_remarks);
				}
								
				
			},
			error: function(xhr, status, thrown) {				
				if(xhr != undefined && xhr.status == 500){}
				else {}
			},
			complete :function(){}
		});
	}
	
	// 회차추가
 	function newAsServiceRecv(){
	
    	if(isEmpty($('#contractsaleorgancd').val())){
    		alert('계약을 선택해 주세요');
    		return;
    	}
    	
    	var existRegOrRecv = false; // 등록이나 접수가 존재하는지
    	
    	
    	var rows = $('#dgRecv').datagrid('getRows');
    	for(var i=0; i<rows.length; i++){
    	  var proc_status = rows[i]['proc_status'];
    	  if (proc_status == '1' || proc_status == '2'){ // 등록이나 접수인 경우
    		  existRegOrRecv = true;
    	  		break;    		  
    	  }
    	}
    	
    	/*
    	if (existRegOrRecv == true){
    		var r = confirm('이미 등록된 회차가 존재합니다. 추가로 회차를 생성하겠습니까?');
    		
    		if (r == false){
    			return;
    		}
    	}
    	*/
    	
    	
    	$('#dlgRecv').dialog('open').dialog('center').dialog('setTitle','회차추가');
        $('#fmAsServiceRecv').form('clear');
        
        $('#recvnrulecd').val($('#contractnrulecd').val()); 
        $('#recvsaleorgancd').val($('#contractsaleorgancd').val());
        $('#recvsaleyear').val($('#contractsaleyear').val());
        $('#recvseqno').val($('#contractseqno').val());
        $('#recvcaretype').combobox('setValue', '1');
        $('#recvcarereqdt').datebox('setValue', getTomorrow());
        $('#recvcarereqtime').timespinner('setValue', '00:00');
        
        var zipcd = $('#contractzipcd').val();
		var prodgroup = $('#contractprodgroup').val();
		getAreaRemarks(zipcd, prodgroup, "R");
        getCareOrgAndManagerRecv();
        serviceNmComboLoading();
        
      	
        
	}
	
   // 회차정보수정
   function editAsServiceRecv(){
   	
   	   var row = $('#dgRecv').datagrid('getSelected');
       if (row){
       	 
			if (row.proc_status != 1 && row.proc_status != 2){ 
   		   		alert('등록이나 접수인 건만 수정 가능합니다.') 
   	   			return;
   	   		}
			var carereqdt = row.carereqdt;
			var carereqtime = row.carereqtime;
			var careendtime = row.careendtime;
				
			if (carereqdt != null && carereqdt.length == 8){
				var cyyyy = carereqdt.substring(0,4);
				var cmm = carereqdt.substring(4,6);
				var cdd = carereqdt.substring(6,8);
				row.carereqdt = cyyyy + '-' + cmm + '-' + cdd;
			}
				
			if( carereqtime !=null && carereqtime.length == 4){
				var hh = carereqtime.substring(0,2);
				var mm = carereqtime.substring(2,4);
				row.carereqtime = hh + ':' + mm;
			}
			if( careendtime !=null && careendtime.length == 4){
				var hh = careendtime.substring(0,2);
				var mm = careendtime.substring(2,4);
				row.careendtime = hh + ':' + mm;
			}
			
           	$('#dlgRecv').dialog('open').dialog('center').dialog('setTitle','회차수정');
           	$('#fmAsServiceRecv').form('load',row);
           	$('#recvmanager_id').combogrid('setValue', {userid:row.manager_id, usernm: row.manager_nm}); // 콤보그리드 데이터 로딩시 방법
           	
           	$('#recvservice_type_cd').combobox(
        			{	valueField: 'service_type_cd',	textField: 'service_type_nm'
        					, data:[{service_type_cd: row.service_type_cd,	service_type_nm: row.service_type_nm }] 
        			}
        	);
        	
           	var zipcd = $('#contractzipcd').val();
    		var prodgroup = $('#contractprodgroup').val();
    		getAreaRemarks(zipcd, prodgroup, "R");
        	
        	serviceNmComboLoading();
        	$('#recvservice_type_cd').combobox('setValue', row.service_type_cd);
       }
   	
   }
   
   // 접수 - 회차 삭제
   function removeAsServiceRecv(){
      	
   	   var row = $('#dgRecv').datagrid('getSelected');
       if (row){
    	   
    	   if (row.proc_status != 1 && row.proc_status != 2){ // 1, 2 아닌 것은 삭제불가능 
    		   	alert('등록이나 접수인 건만 삭제 가능합니다.') 
    	   		return;
    	   }
    	   
    	   $.messager.confirm('confirm', '삭제하시겠습니까?',function(r){
               if (r){
                   $.post('/customer/removeRecv.do'
                		,{id:row.id}
                   		,function(result){
                       		
                    		if (result.errorMsg){
                        	   
                        	   alert('에러가 발생했습니다. ' + result.errorMsg);
                           } else {
                        	   alert('삭제하였습니다.  ' );                        	    
                        	   getRecvList();
                           }
                   },'json');
               }
           });
    	   
    	   
       }
   	
   }
   
   // 등록상태로 바꾸기
   function toRegisterAsServiceRecv(){
     	
   	   var row = $('#dgRecv').datagrid('getSelected');
       if (row){
    	   
    	   $.messager.confirm('confirm', '등록상태로 바꾸시겠습니까?',function(r){
               if (r){
                   $.post('/customer/toRegisterRecv.do'
                		,{id:row.id}
                   		,function(result){
                       
                    		if (result.errorMsg){
                    			  alert('에러가 발생했습니다. ' + result.errorMsg);
                           } else {
                        	   alert('등록상태로 바꾸었습니다. ' );
                        	   getRecvList();
                           }
                   },'json');
               }
           });
    	   
    	   
       }
   	
   }
   
   // 접수탭 - 회차저장
   function saveAsServiceRecv(){
	   var r = confirm('저장 하시겠습니까?');
	   if (r == false){
		   return;
	   }
       	$('#fmAsServiceRecv').form('submit',{
               url: '/customer/saveRecv.do',
               onSubmit: function(){
                   return $(this).form('validate');
               },
               success: function(result){
                   var result = eval('('+result+')');
                   if (result.errorMsg){
                      alert('접수 정보 저장시 에러 발생');
                   } else {
                       //alert('접수정보를 저장했습니다');
                       $('#dlgRecv').dialog('close');
                       getRecvList();
                   }
               }
           });
   }
	
   // 계약해지정보 초기화 
   function clearCloseInfo(){
  		$('#czcontractno').text('');
		$('#cztot_srv_turn').text('');
		$('#czcarecnt').text('');
		$('#czprodnm').text('');
		$('#czqy_py').text('');
		
		$('#czserviceperiod').text('');
		$('#czcarefee').text('');
		$('#cztotcarecnt').text('');
		$('#cztotcareamt').text('');
		$('#czaccrentamt').text('');
		
		$('#czcancelpenalty').text('');
		$('#czmemdccancelpenalty').text('');
		$('#czdcpenalty').text('');
		$('#cztotpenalty').text('');
		$('#czcalcamt').text('');
		$('#czfinalcalamt').text(''); // 최종정산금
		$('#czrealcalamt').val('');	//조정정산금
	}
   
	// 내역산출 - 계약해지
   function reqCalcClose(){
   	var saleorgancd = $('#contractsaleorgancd').val();
   	var saleyear = $('#contractsaleyear').val();
   	var seqno = $('#contractseqno').val();
   	if(isEmpty(saleorgancd)){
   		alert('계약해지를 위한 계약을 선택해 주세요');
   		return;
   	}
   	
   	$.ajax({
   			url : "/customer/reqCalc.do",
   			type : "POST",
   			dataType : "json",
   			data: {
   				event_type: '2',
   				saleorgancd: saleorgancd,
   				saleyear: saleyear,
   				seqno: seqno
   			},
   			success : function(resp){
   				console.log(resp.res);
   				if (resp.res == null){
   					alert('내역신청요청에러');
   					return;
   				}
   				$('#czcontractno').text(resp.res.contractno);
   				$('#cztot_srv_turn').text(resp.res.tot_srv_turn);
   				$('#czcarecnt').text(resp.res.carecnt);
   				$('#czprodnm').text(resp.res.prodnm);
   				$('#czqy_py').text(resp.res.qy_py);
   				
   				$('#czserviceperiod').text(resp.res.serviceperiod);
   				$('#czcarefee').text(resp.res.carefee);
   				$('#cztotcarecnt').text(resp.res.totcarecnt);
   				$('#cztotcareamt').text(resp.res.totcareamt);
   				$('#czaccrentamt').text(resp.res.accrentamt);
   				
   				$('#czcancelpenalty').text(resp.res.cancelpenalty);
   				$('#czmemdccancelpenalty').text(resp.res.memdccancelpenalty);
   				$('#czdcpenalty').text(resp.res.dcpenalty);
   				$('#cztotpenalty').text(resp.res.totpenalty);
   				$('#czcalcamt').text(resp.res.calcamt);
   				$('#czfinalcalamt').text(resp.res.finalcalamt); // 최종정산금
   				$('#czrealcalamt').val(resp.res.finalcalamt);	//조정정산금 - 처음엔 최종정산금과 같은 금액으로 설정한다.
   				
   				alert('내역을 산정했습니다');
   			},
   			error: function(xhr, status, thrown) {
   				alert('내역산정에러');
   			},
   			complete :function(){		
   			
   			}
   	});
	}

	// 내역산출 - 계약해지
   function reqCalcCloseNew(){
   	var saleorgancd = $('#contractsaleorgancd').val();
   	var saleyear = $('#contractsaleyear').val();
   	var seqno = $('#contractseqno').val();
   	if(isEmpty(saleorgancd)){
   		alert('계약해지를 위한 계약을 선택해 주세요');
   		return;
   	}
   	
   	$.ajax({
   			url : "/customer/reqCalcNew.do",
   			type : "POST",
   			dataType : "json",
   			data: {
   				event_type: '2',
   				saleorgancd: saleorgancd,
   				saleyear: saleyear,
   				seqno: seqno
   			},
   			success : function(resp){
   				console.log(resp.res);
   				if (resp.res == null){
   					alert('내역신청요청에러');
   					return;
   				}
   				$('#czcontractno').text(resp.res.contractno);
   				$('#cztot_srv_turn').text(resp.res.tot_srv_turn);
   				$('#czcarecnt').text(resp.res.carecnt);
   				$('#czprodnm').text(resp.res.prodnm);
   				$('#czqy_py').text(resp.res.qy_py);
   				
   				$('#czserviceperiod').text(resp.res.serviceperiod);
   				$('#czcarefee').text(resp.res.carefee);
   				$('#cztotcarecnt').text(resp.res.totcarecnt);
   				$('#cztotcareamt').text(resp.res.totcareamt);
   				$('#czaccrentamt').text(resp.res.accrentamt);
   				
   				$('#czcancelpenalty').text(resp.res.cancelpenalty);
   				$('#czmemdccancelpenalty').text(resp.res.memdccancelpenalty);
   				$('#czdcpenalty').text(resp.res.dcpenalty);
   				$('#cztotpenalty').text(resp.res.totpenalty);
   				$('#czcalcamt').text(resp.res.calcamt);
   				$('#czfinalcalamt').text(resp.res.finalcalamt); // 최종정산금
   				$('#czrealcalamt').val(resp.res.finalcalamt);	//조정정산금 - 처음엔 최종정산금과 같은 금액으로 설정한다.
   				
   				alert('내역을 산정했습니다');
   			},
   			error: function(xhr, status, thrown) {
   				alert('내역산정에러');
   			},
   			complete :function(){		
   			
   			}
   		});
	}

	// 해지시 수납다이얼로그
	function openDlgClosePay(){
		var b = isAC();
 		if(b==false){
 			alert('사용할 권한이 없습니다.');
 			return;
 		}
 		
	   	var row = new Object();
	   	var nrulecd = $('#contractnrulecd').val();
	   	var juminno1 = $('#contractjuminno1').val();
	   	var prodnm = $('#contractprodnm').val();
	   	var custid = $('#gmcustid').val();
	   	row.saleorgancd = $('#contractsaleorgancd').val();
	   	row.reasontype = '1'; // 수납환불이유: 1: 해지 2: 일반
	   	
	   	if (isEmpty( row.saleorgancd)){
	   		alert('해지를 위한 계약을 선택해 주세요');
	   		return;
	   	}
	   	
	   	row.saleyear = $('#contractsaleyear').val();
	   	row.seqno = $('#contractseqno').val();
	   	row.custid = custid;
	   	row.prodnm = prodnm;
	   	
	   	
	 	// 여기서 ajax 요청이 한 번 가야 함. 해지전에 등록, 컨택완료인 것이 있는지 확인한다.
	 	
	 	$.ajax({
			url : "/customer/getExistAsServiceOfSchedule.do",
			type : "POST",
			dataType : "json",
			data: {
				custid: row.custid,
				saleorgancd: row.saleorgancd,
				saleyear: row.saleyear,
				seqno: row.seqno
			},
			success : function(res){
				
				var exist = res.exist;
				if (exist == true){
	 				alert("계약에 등록이거나 컨택완료인 서비스가 있습니다. 먼저 처리하고 해지를 해야 합니다.");
					return;
				}
				
				// 나머지 작업
				$('#paycardapprovaldt').datebox('setValue', getToday());
			   	$('#paycardapprovaldt').datebox('disable');
			   	
			   	var realcalcamt = $('#czrealcalamt').val();
			   	if (nrulecd == '1'){
			   		$('#paypaymentamt').textbox('setValue', Math.abs(realcalcamt)) ; // 환불시 마이너스금액을 전환
			   	}
			   	
			   	$('#fmPay').form('load', row);
				$('#dlgPay').dialog('open');
				
				
				$('#payrentyyyymm').val(moment().format('YYYYMM')); // 해지시에는 이번월을 넣어준다.  
				
				if (realcalcamt >=0){
					$('#payreceivegb').combobox('select', '1'); // 수납 
				}else{
					$('#payreceivegb').combobox('select', '2'); // 환불
				}
				
			 	// 해지탭에서 연 경우 무조건 해지영역을 보인다
			 	if(row.reasontype == '1'){
			 		$('#divCloseContract').show();
			 	}
					
			},
			error: function(xhr, status, thrown) {},
			complete :function(){}
		});
	   	
	   	
		
   }
	

	 // 계약저장
    function saveNewContract(){
    	var r = confirm('저장하시겠습니까?');
		if (r != true){
			return;
		}
		
		//여기
    	$('#fmContract').form('submit',{
            url: '/customer/saveContract.do',
            dataType: 'json',
            onSubmit: function(){
            	
            	if ( isEmpty($('#newcontractsaleorgancd').textbox('getValue') ) || $('#newcontractsaleorgancd').textbox('getValue') == 0){
            		alert('판매기관은 필수입니다');
            		return false;
            	}
            	
            	if ( isEmpty($('#newcontractprodcd').textbox('getValue') )){
            		alert('상품은 필수입니다');
            		return false;
            	}
            	
            	if ( isEmpty($('#newcontractrcptorgancd').combobox('getValue') ) 
            			|| isEmpty($('#newcontractmanager_id').combobox('getValue') )
            			){
            		alert('케어지점 혹은 케어매니저는 필수입니다');
            		return false;
            	}

                /*2021-11-01 , 상품그룹 홈클리닝인 경우 매니저2 필수 처리 추가(매니저1 : 청소책임자, 매니저2 : 점검담당자) */
                if($('#newcontractprodgroup').combobox('getValue') === '5' && isEmpty($('#newcontractadd_manager_id1').combobox('getValue'))){
                    alert('점검담당자는 필수입니다');
                    return false;
                }

            	

            	// 계약 신규일시
            	if (isEmpty($('#newcontractid').val())==true){
            		if (isEmpty($('#newcontractpt_code').combobox('getValue'))==true){
            			alert('패턴코드는 필수입니다');
            			return false;
            		}
            		
            		// 멤버쉽인 경우
            		if ($('#newcontractnrulecd').combobox('getValue') == '1' ){
            			
            			if (isEmpty($('#file_id').val())==true ){                			 
            				alert('멤버쉽 신규 계약시 계약서는 필수입니다');
            				return false;
            			}
            			
            			if ($('#newcontractconperd_cd').combobox('getValue')== '0' ){                			 
            				alert('멤버쉽 신규 계약시 계약기간은 필수입니다');
            				return false;
            			}
            			
            			if ($('#newcontractserviceperiod').combobox('getValue')== '0' ){                   			 
            				alert('멤버쉽 신규 계약시 서비스주기는 필수입니다');
            				return false;
            			}
            		}
            		
            		if ($('#newcontractnrulecd').combobox('getValue') == '2' 
        					&& isEmpty($('#newcontractdcrate').combobox('getValue'))==true){
            			alert('일반 신규 계약시 할인율은 필수입니다.');
            			return false;
        			}
            		var breakflag = true;
            		$("input[name='addproductcost']").each(function(index){
            			if(index >0){
	            			if($(this).val()==""){
	            				alert("추가상품 가격을 입력해주세요.");
	            				breakflag = false;
	            			}
            			}
            		})
            		if(!breakflag){
            			return false;
            		}
            		$("input[name='addproduct']").each(function(index){
            			if(index >0){
	            			if($(this).val()==""){
	            				alert("추가상품명을 입력해주세요.");
	            				breakflag = false;
	            			}
            			}
            		})
            		if(!breakflag){
            			return false;
            		}
            		
            		
            	}
            	// 계약 업데이트라면
            	if (isEmpty($('#newcontractid').val())!=true){
            		/*
                    var avail_instant_chg = $('#newcontractavail_instant_chg').val(); // 즉시변경여부
                    var calcamt =  $('#newcontractcalcamt').val();// 정산금액
                    if (avail_instant_chg != 'T'){
                        var r = confirm('정산금액이 발생합니다. 금액은 ' + calcamt + '입니다. 계속하시겠습니까?');
                        if (r == false){
                            return false;
                        }
                    }*/
                }
                return true;
            },
            success: function(result){
            	
                var result = eval('('+result+')');
                
                if (result.errcd == 'ERR_0000'){
                	alert('계약을 저장하였습니다.');
                	
                	$('#dlgContract').dialog('close');                    	                                              
                	//$('#dgContract').datagrid('reload');
                	//$('#dgPayContract').datagrid('reload');
                	
                	
                	getDgContractList();
                	getDgPayContractList();
                	
                    
                    
                }else if (result.errcd == 'INFO_0100'){
                	alert('계약을 저장했습니다. 멤버쉽 계약을 위한 계정정보가 없으니 계정 정보를 등록해 주십시오.');
                	$('#dlgContract').dialog('close');                    	                                         
                	//$('#dgContract').datagrid('reload');
                	//$('#dgPayContract').datagrid('reload');
                	getDgContractList();
                	getDgPayContractList();
                	
                }else{
                	alert('계약 저장시 에러가 발생했습니다. ' + result.errmsg);
                }
            }
        });
    }
	
	// 특이사항과 계약서만 저장
	function saveRemarkContract(){
    	
		var r = confirm('저장하시겠습니까?');
		if (r != true){
			return;
		}
    	$('#fmContract').form('submit',{
            url: '/customer/saveRemarkContract.do',
            dataType: 'json',
            onSubmit: function(){
                return $(this).form('validate');
            },
            success: function(result){
            	
                var result = eval('('+result+')');
                if (result.errcd == 'ERR_0000'){
                	alert('계약 특이사항을 저장하였습니다.');  
                	$('#dlgContract').dialog('close');                    	                                              
                	//$('#dgContract').datagrid('reload');
                	//$('#dgPayContract').datagrid('reload');
                	getDgContractList();
                	getDgPayContractList();
                }else{
                	alert('계약 특이사항 저장시 에러가 발생했습니다. ' + result.errmsg);
                }
            }
        });
    }
    
   
 	function openSearchCustomer(){
    	console.log('openSearchCustomer');
    	$('#dgSearchedCust').datagrid('loadData', {"total":0,"rows":[]});
    	
    	$('#searchCust').searchbox('textbox').focus(); // not work
    	$('#dlgUser').dialog('open');
    }
    
    
 	
    
    
    
    // 해지된 계약보기 토글
    function toggleShowCloseContract(){
    	
    	g_showclose = g_showclose^1;
    	
    	
    	$.ajax({
    		url : "/customer/getContractList.do",
    		type : "POST",
    		dataType : "json",
    		data: {
    			custid: g_custid,
				showclose: g_showclose 
    		},
    		success : function(response){
    			
    			if (response.rows != null){
    				$('#dgContract').datagrid({data: response.rows}); 
    				$('#dgGeneralContract').datagrid({data: response.rowsGeneral});
    			}else{
    				$('#dgContract').datagrid('loadData', []);
    				$('#dgGeneralContract').datagrid('loadData', []);
    			}
    		},
    		error: function(xhr, status, thrown) {
    			
    			//console.log('접수정보수신시 에러 발생');
    			alert('계약정보 정보수신시 에러 발생 ');
    		},
    		complete :function(){		
    			
    		}
    	});
    }
    
    // 계약추가
    function openNewContractDlg(){    	
    	delArr= new Array()
    	$("#delAddProductId").val('');
    	
    	$('#newcontractid').val(''); // 신규이므로 아이디 필드를 비운다. 
    	
    	$('#newcontractprodcd').combobox('setValue', '');
    	$('#newcontractqy_py').textbox('setValue', '1');
    	$('#newcontractcontractdt').datebox('setValue', getToday());
    	$('#newcontractnrulecd').combobox('setValue', '2');
    	
    	
    	$('#newcontractmemcost').textbox('setValue', '');
    	$('#newcontractmemcarefee').textbox('setValue', '');
    	
    	$('#newcontractdcprice').textbox('setValue', '');
    	$('#newcontractgencost').textbox('setValue', '');
    	$('#newcontractgencarefee').textbox('setValue', '');
    	
    	$('#newcontractremarks').textbox('setValue', '');
    	$('#newcontractordr_no').textbox('setValue', '');
    	$('#newcontractcarereqdt').textbox('setValue', '');
    	$('#newcontractcarereqtime').textbox('setValue', '00:00');
    	$('#newcontractcareendtime').textbox('setValue', '00:00');
    	
    	
    	$('#newcontractot_srv_turn').numberbox('setValue', '1'); 
    	
    	$('#newcontractpay_gb').combobox('setValue', '2');
    	$('#newcontractcarereqdt').datebox('setValue', getTomorrow());
    	
    	
    	$('#newcontractremarks').textbox('setValue', '');
    	$('#newcontractsaleorgancd').textbox('setValue', '');
    	$('#newcontractsaleuserid').textbox('setValue', '');
    	$('#newcontractrcptorgancd').textbox('setValue', '');
    	
    	$('#newcontractmanager_id').textbox('setValue', '');
    	$('#newcontractadd_manager_id1').textbox('setValue', '');
    	$('#newcontractmanager_id2').textbox('setValue', '');
    	$('#schmanager_id').textbox('setValue', '');
    	
    	$('#newcontractrcptorgancd1').textbox('setValue', '');
    	$('#newcontractrcptorgancd2').textbox('setValue', '');
    	
    	$('#fileView').html('[첨부된파일없음]');
    	$('#file_id').val('');
    	$('#file_seq').val('');
    	$('#file_url').val('');
    	$('#newcontractot_srv_turn').numberbox('readonly',true);
    	$('#newcontractordr_no').textbox('setValue', '');
    	

		$('#newcontractcontractdt').datebox('readonly', false);
		$('#newcontractordr_no').textbox('readonly', false);
		$('#newcontractnrulecd').combobox('readonly', false);
		$('#newcontractprodgroup').combobox('readonly', false);
		$('#newcontractconperd_cd').combobox('readonly', false);
		$('#newcontractpay_gb').combobox('readonly', false);
		$('#newcontractcmpns_yn').combobox('readonly', false);
		
		
		$('#newcontractsaleorgancd').combobox('enable');
		$('#newcontractsaleuserid').combobox('enable');
		$('#newcontractrcptorgancd').combobox('enable');
		$('#newcontractmanager_id').combobox('enable');
		
		$('#newcontractrcptorgancd1').combobox('enable');
		$('#newcontractadd_manager_id1').combobox('enable');
		$('#newcontractrcptorgancd2').combobox('enable');
		$('#newcontractadd_manager_id2').combobox('enable');
		
		$('#newcontractcarereqdt').combobox('readonly', false);
		$('#newcontractcarereqtime').combobox('readonly', false);
		$('#newcontractcareendtime').combobox('readonly', false);
		$('#newcontractinit_proc_status').combobox('readonly', false);
		
    	$('#dlgContract').dialog('open');
    	$('#divNewContractMembership').hide();
		$('#divNewContractFile').hide();
		$('#divNewContractGeneral').show();
		
		// add below
		$('#newcontractdcrate').combobox('setValue', '0');
		$('#newcontractserviceperiod').combobox('setValue', '0'); // 선택
		$('#newcontractot_srv_turn').numberbox('setValue', '1');
		$('#newcontractpt_code').combobox('setValue', '');
		getSaleOrgAndSaleUser(); // 로그인한 사용자의 판매기관과 판매자로 설정
		getCareOrgAndManager();
		
		g_fitDlgSize('dlgContract');
		$('#divChgContract').hide();
		$('#btnSaveNewContract').show();
		$('#btnSaveRemarkContract').hide();
		$("#btnAddProductHistory").hide();
		$("#btnProductHistory").hide();
		// 관리권역설정가져오기
		var zipcd = $('#gmzipcd').val();
		var prodgroup = $('#newcontractprodgroup').combobox('getValue');		
		getAreaRemarks(zipcd, prodgroup, 'C');
		
		$("#addproductdiv").find('div').each(function(index){
			if(index > 0){
				$(this).remove();
			}
		})
		$("#addproductdiv").find('input').each(function(index){
			$(this).val("");
		})
		$("#addtotalcost").val(0);
		$("#addtotalcosttxt").html(0)
    	
    }
    
    // 계약수정
    // 계약수정은 멤버쉽만 해당한다. - 2017.12.26. 일반인 경우는 설계 필요.
    function openEditContractDlg(row){
 
    	$('#newcontractsaleorgancd').combobox('setValue', row.saleorgancd);
    	$('#newcontractsaleuserid').combobox('setValue', row.saleuserid);
    	
    	
    	
    	// organ
//     	$('#newcontractrcptorgancd').combobox(
//     			{	valueField: 'organcd',	textField: 'organnm', data:[{organcd: row.rcptorgancd,	organnm: row.rcptorgannm }] 
//     	});
    	$('#newcontractrcptorgancd').combobox('setValue', row.rcptorgancd);
    	
    	$('#newcontractmanager_id').combobox(
    			{	valueField: 'userid',	textField: 'usernm', data:[{userid: row.manager_id,	usernm: row.manager_nm }] 
    	});
    	$('#newcontractmanager_id').combobox('setValue', row.manager_id);
    	
    	if (isEmpty(row.add_manager_id1) == false){
    		
//     		$('#newcontractrcptorgancd1').combobox(
// 	    			{	valueField: 'organcd',	textField: 'organnm', data:[{organcd: row.rcptorgancd1,	organnm: row.rcptorgannm1 }] 
// 	    	});
// 	    	$('#newcontractrcptorgancd1').combobox('setValue', row.rcptorgancd1);
	    	
//     		$('#newcontractadd_manager_id1').combobox(
// 	    			{	valueField: 'userid',	textField: 'usernm', data:[{userid: row.add_manager_id1,	usernm: row.add_manager_nm1 }] 
// 	    	});
// 	    	$('#newcontractadd_manager_id1').combobox('setValue', row.add_manager_id1);
    	}
    	
    	if (isEmpty(row.add_manager_id2) == false){
    		$('#newcontractrcptorgancd2').combobox(
	    			{	valueField: 'organcd',	textField: 'organnm', data:[{organcd: row.rcptorgancd2,	organnm: row.rcptorgannm2 }] 
	    	});
	    	$('#newcontractrcptorgancd2').combobox('setValue', row.rcptorgancd2);
	    	
	    	$('#newcontractmanager_id2').combobox(
	    			{	valueField: 'userid',	textField: 'usernm', data:[{userid: row.add_manager_id2,	usernm: row.add_manager_nm2 }] 
	    	});
	    	$('#newcontractmanager_id2').combobox('setValue', row.add_manager_id2);
    	}
      	
    	
    	
    	$('#newcontractprodgroup').combobox('setValue', row.prodgroup);


    	$('#newcontractid').val(row.id);
    	$('#newcontractavail_instant_chg').val(row.avail_instant_chg);
    	$('#newcontractcalcamt').val(row.calcamt);

		var joItemDtl = getProdCdByProdGroup(row.prodgroup, 'ALL');
		$('#newcontractprodcd').combobox({
			valueField: 'prodcd',
			textField: 'prodnm',
			data: joItemDtl
		});
    	
		var joPattenCode = getPatternCode(row.nrulecd, row.prodgroup);
		$('#newcontractpt_code').combobox({
			valueField: 'pt_code',
			textField: 'pt_nm',
			data: joPattenCode
		});
        $('#newcontractpt_code').combobox('setValue', row.pt_code);

    	$('#newcontractqy_py').textbox('setValue', row.qy_py);
    	$('#newcontractcontractdt').datebox('setValue', getEasyUiDateFromString(row.contractdt));
    	$('#newcontractnrulecd').combobox('setValue', row.nrulecd);
    	$('#newcontractconperd_cd').combobox('setValue', row.conperd_cd);
    	
    	$('#newcontractremarks').textbox('setValue', row.remarks);
    	//$('#newcontractarea_remarks').textbox('setValue', row.area_remarks);
    	$('#newcontractordr_no').textbox('setValue', row.ordr_no);
    	$('#newcontractcarereqdt').datebox('setValue', getEasyUiDateFromString(row.carereqdt));
    	$('#newcontractcarereqtime').textbox('setValue', getEasyUiTimeFromString(row.carereqtime));
    	$('#newcontractcareendtime').textbox('setValue', getEasyUiTimeFromString(row.careendtime));
    	$('#newcontractot_srv_turn').numberbox('setValue', row.tot_srv_turn); 
    	$('#newcontractpay_gb').combobox('setValue', row.pay_gb);
    	$('#newcontractcmpns_yn').combobox('setValue', row.cmpns_yn);
    	
    	$('#newcontractremarks').textbox('setValue', row.remarks);
    	
    	$('#fileView').html('[파일첨부]');
    	$('#file_id').val(row.file_id);
    	$('#file_seq').val(row.file_seq);
    	$('#file_url').val(row.file_url);
    	
    	$('#newcontractprodcd').combobox('setValue', row.prodcd); // bug fix - prodcd 의 combobox 목록을 설정한 후 바로 set하면 값이 안 들어간다.
    	$('#newcontractserviceperiod').combobox('setValue', row.serviceperiod);  
    	
    	$('#dlgContract').dialog('open');
    	
    	if (row.nrulecd == '1'){
    		// membership
	    	
    	}else{
    		// general
    		$('#newcontractdcrate').combobox('setValue', row.dcrate);
    		$('#newcontractdcprice').textbox('setValue', row.dcprice);
    	
    		var add_product_price = 0;
    		if(row.add_product_price == 'undefined' || row.add_product_price == null){
    			add_product_price = 0;
    		}else{
    			add_product_price = row.add_product_price	
    		}
    		var dcprice = 0;
    		if(row.dcprice == 'undefined' || row.dcprice==null){
    			dcprice =0;
    		}else{
    			dcprice = row.dcprice
    		}
    		console.dir("!"+row.carefee)
    		console.dir("!"+row.dcprice)
    		console.dir("!"+add_product_price)
	    	$('#newcontractgencost').textbox('setValue', row.carefee + dcprice - add_product_price  );
	    	$('#newcontractgencarefee').textbox('setValue', row.carefee);
    	}
    	
    	// membership
    	if (row.nrulecd == '1'){
    		$('#divNewContractMembership').show();
    		$('#divNewContractGeneral').hide();
    		$('#divNewContractFile').show();
    	}else{
    		// general
    		$('#divNewContractMembership').hide();
    		$('#divNewContractGeneral').show();
    		$('#btnSaveNewContract').hide(); // 일반인경우 저장버튼을 가린다. 
    		$('#divNewContractFile').hide();
    	}
    	var add_product_price = 0;
		if(row.add_product_price == 'undefined' || row.add_product_price == null){
			add_product_price = 0;
		}else{
			add_product_price = row.add_product_price	
		}
    	$("#addtotalcost").val(add_product_price);
    	$("#addtotalcosttxt").html(add_product_price.toLocaleString())
    	$("#addproductdiv").find('div').each(function(index){
			if(index > 0){
				$(this).remove();
			}
		})
    	getAddProduct(row.contract_id);
    	$("#btnAddProductHistory").show();
    	$("#btnProductHistory").show();
    	$("#history_contract_id").val(row.contract_id);
		//$('#divNewContractFile').hide();
		
		
		$('#newcontractcontractdt').datebox('readonly', true);
		$('#newcontractordr_no').textbox('readonly', true);
		$('#area_remarks').textbox('readonly', true);
		$('#newcontractnrulecd').combobox('readonly', true);
		$('#newcontractprodgroup').combobox('readonly', true);
		$('#newcontractconperd_cd').combobox('readonly', true);
		$('#newcontractpay_gb').combobox('readonly', true);
		$('#newcontractcmpns_yn').combobox('readonly', true);
		$('#newcontractcarereqdt').combobox('readonly', true);
		$('#newcontractcarereqtime').combobox('readonly', true);
		$('#newcontractcareendtime').combobox('readonly', true);

		$('#newcontractot_srv_turn').numberbox('readonly',true);
		$('#newcontractot_srv_turn').numberbox('readonly',true);
		$('#newcontractinit_proc_status').combobox('readonly', true);
		
		// 관리권역설정가져오기
		var zipcd = $('#gmzipcd').val();
		var prodgroup = $('#newcontractprodgroup').combobox('getValue');		
		getAreaRemarks(zipcd, prodgroup, 'C');
		
		var nrulecd = $('#newcontractnrulecd').combobox('getValue');
		var avail_instant_chg = $('#newcontractavail_instant_chg').val();
		
		$('#divChgContract').hide();
		$('#btnSaveNewContract').show();
		$('#btnSaveRemarkContract').show();
		
		if (nrulecd == '1'){ // 멤버쉽
			
			if (avail_instant_chg == 'T'){
				
			}else{
				//$('#divChgContract').show(); // 현수계장 요청. 2018.10.5 멤버쉽 계약 변경 기능 보이지 않도록  
				$('#btnSaveNewContract').hide();
			}
		}else{ // 일반인 경우 계약 저장 버튼을 막는다. 
			$('#divChgContract').hide();
			$('#btnSaveNewContract').hide();
		}
		
		g_fitDlgSize('dlgContract');
		
		
    
    }
    
    // 일반계약변경
    function openEditGenContractDlg(){
    	var row = $('#dgGeneralContract').datagrid('getSelected');
    	delArr = new Array();
    	$('#delAddProductId').val("")
    	if(row == null){
    		$.messager.alert({
				title: '알림',
				msg: '변경할 일반 계약을 선택해 주십시오.',
				icon: 'info',
				top:200
			});
    		return;
    	}
    	
    	if(row.nrulecd != '2'){
    		$.messager.alert({
				title: '알림',
				msg: '일반 계약만 변경이 가능합니다.',
				icon: 'info',
				top:200
			});
    		return;
    	}
    	$("#contractId").val(row.contract_id)
    	$('#newcontractsaleorgancd').combobox('setValue', row.saleorgancd);
    	$('#newcontractsaleuserid').combobox('setValue', row.saleuserid);
    	$("#btnAddProductHistory").show();
    	$("#btnProductHistory").show();
    	// organ
//     	$('#newcontractrcptorgancd').combobox(
//     			{	valueField: 'organcd',	textField: 'organnm', data:[{organcd: row.rcptorgancd,	organnm: row.rcptorgannm }] 
//     	});
    	$('#newcontractrcptorgancd').combobox('setValue', row.rcptorgancd);
    	
    	$('#newcontractmanager_id').combobox(
    			{	valueField: 'userid',	textField: 'usernm', data:[{userid: row.manager_id,	usernm: row.manager_nm }] 
    	});
    	$('#newcontractmanager_id').combobox('setValue', row.manager_id);
    	
    	
		if (isEmpty(row.add_manager_id1) == false){
    		
//     		$('#newcontractrcptorgancd1').combobox(
// 	    			{	valueField: 'organcd',	textField: 'organnm', data:[{organcd: row.rcptorgancd1,	organnm: row.rcptorgannm1 }] 
// 	    	});
// 	    	$('#newcontractrcptorgancd1').combobox('setValue', row.rcptorgancd1);
	    	
//     		$('#newcontractadd_manager_id1').combobox(
// 	    			{	valueField: 'userid',	textField: 'usernm', data:[{userid: row.add_manager_id1,	usernm: row.add_manager_nm1 }] 
// 	    	});
// 	    	$('#newcontractadd_manager_id1').combobox('setValue', row.add_manager_id1);
    	}

    	if (isEmpty(row.add_manager_id2) == false){
    		$('#newcontractrcptorgancd2').combobox(
	    			{	valueField: 'organcd',	textField: 'organnm', data:[{organcd: row.rcptorgancd2,	organnm: row.rcptorgannm2 }] 
	    	});
	    	$('#newcontractrcptorgancd2').combobox('setValue', row.rcptorgancd2);
	    	
	    	$('#newcontractmanager_id2').combobox(
	    			{	valueField: 'userid',	textField: 'usernm', data:[{userid: row.add_manager_id2,	usernm: row.add_manager_nm2 }] 
	    	});
	    	$('#newcontractmanager_id2').combobox('setValue', row.add_manager_id2);
    	}
      	
    	
    	
    	$('#newcontractprodgroup').combobox('setValue', row.prodgroup);


    	$('#newcontractid').val(row.id);
    	$('#newcontractavail_instant_chg').val(row.avail_instant_chg);
    	$('#newcontractcalcamt').val(row.calcamt);

		var joItemDtl = getProdCdByProdGroup(row.prodgroup, 'ALL');
		// console.log(joItemDtl);
		$('#newcontractprodcd').combobox({
			valueField: 'prodcd',
			textField: 'prodnm',
			data: joItemDtl
		});
    	
		var joPattenCode = getPatternCode(row.nrulecd, row.prodgroup);
		
		$('#newcontractpt_code').combobox({
			valueField: 'pt_code',
			textField: 'pt_nm',
			data: joPattenCode
		});
		$('#newcontractpt_code').combobox('setValue', row.pt_code);
		
    	$('#newcontractqy_py').textbox('setValue', row.qy_py);
    	$('#newcontractcontractdt').datebox('setValue', getEasyUiDateFromString(row.contractdt));
    	$('#newcontractnrulecd').combobox('setValue', row.nrulecd);
    	$('#newcontractconperd_cd').combobox('setValue', row.conperd_cd);
    	if(row.nrulecd =='2' &&  row.prodgroup=='5'){
    		$("#prodbox").show()
    	}
    	$('#newcontractremarks').textbox('setValue', row.remarks);
    	$('#newcontractordr_no').textbox('setValue', row.ordr_no);
    	$('#newcontractcarereqdt').datebox('setValue', getEasyUiDateFromString(row.carereqdt));
    	$('#newcontractcarereqtime').textbox('setValue', getEasyUiTimeFromString(row.carereqtime));
    	$('#newcontractcareendtime').textbox('setValue', getEasyUiTimeFromString(row.careendtime));
    	$('#newcontractot_srv_turn').numberbox('setValue', row.tot_srv_turn); 
    	$('#newcontractpay_gb').combobox('setValue', row.pay_gb);
    	$('#newcontractcmpns_yn').combobox('setValue', row.cmpns_yn);
    	
    	$('#newcontractremarks').textbox('setValue', row.remarks);
    	
    	
    	
    	$('#newcontractprodcd').combobox('setValue', row.prodcd); // bug fix - prodcd 의 combobox 목록을 설정한 후 바로 set하면 값이 안 들어간다.
    	$('#newcontractserviceperiod').combobox('setValue', row.serviceperiod);  
    	
    	$('#dlgContract').dialog('open');
    	
    	
   		// general
    	var add_product_price = 0;
		if(row.add_product_price == 'undefined' || row.add_product_price == null){
			add_product_price = 0;
		}else{
			add_product_price = row.add_product_price	
		}
		var dcprice = 0;
		if(row.dcprice == 'undefined' || row.dcprice==null){
			dcprice =0;
		}else{
			dcprice = row.dcprice
		}
   		$('#newcontractdcrate').combobox('setValue', row.dcrate);
   		$('#newcontractdcprice').textbox('setValue', row.dcprice);
   		$('#newcontractgencost').textbox('setValue', row.carefee + dcprice - add_product_price  );
    	$('#newcontractgencarefee').textbox('setValue', row.carefee);
    	var add_product_price = 0;
		if(row.add_product_price == 'undefined' || row.add_product_price == null){
			add_product_price = 0;
		}else{
			add_product_price = row.add_product_price	
		}
    	$("#addtotalcost").val(add_product_price);
    	$("#addtotalcosttxt").html(add_product_price.toLocaleString())
    	$("#addproductdiv").find('div').each(function(index){
			if(index > 0){
				$(this).remove();
			}
		})
    	getAddProduct(row.contract_id);
    	$("#history_contract_id").val(row.contract_id);
   		// general
   		$('#divNewContractMembership').hide();
   		$('#divNewContractGeneral').show(); 
   		$('#divNewContractFile').hide();
    	
		
		$('#newcontractcontractdt').datebox('readonly', true);
		$('#newcontractordr_no').textbox('readonly', true);
		$('#area_remarks').textbox('readonly', true);
		$('#newcontractnrulecd').combobox('readonly', true);
		$('#newcontractprodgroup').combobox('readonly', true);
		$('#newcontractconperd_cd').combobox('readonly', true);
		$('#newcontractpay_gb').combobox('readonly', true);
		$('#newcontractcmpns_yn').combobox('readonly', true);
		$('#newcontractcarereqdt').combobox('readonly', true);
		$('#newcontractcarereqtime').combobox('readonly', true);
		$('#newcontractcareendtime').combobox('readonly', true);
		$('#newcontractot_srv_turn').numberbox('readonly',true);
		$('#newcontractot_srv_turn').numberbox('readonly',true);
		$('#newcontractinit_proc_status').combobox('readonly', true);
		
		// 관리권역설정가져오기
		var zipcd = $('#gmzipcd').val();
		var prodgroup = $('#newcontractprodgroup').combobox('getValue');		
		getAreaRemarks(zipcd, prodgroup, 'C');
		
		var nrulecd = $('#newcontractnrulecd').combobox('getValue');
		var avail_instant_chg = $('#newcontractavail_instant_chg').val();
		
		$('#divChgContract').hide();
		$('#btnSaveNewContract').show();
		$('#btnSaveRemarkContract').show();
		
		
		/*
		if (avail_instant_chg == 'T'){
			
		}else{
			
			$('#btnSaveNewContract').hide();
		}*/
		
		
		g_fitDlgSize('dlgContract');
		
		
    
    }
 
 	// 계약해지
    function saveCloseContract(){
 		alert('사용하지 않는 기능입니다');
 		return;
 		/*
    	var url =  '/customer/saveCloseContract.do';
	    $('#fmCloseContract').form('submit',{
	        url: url,
	        onSubmit: function(){
	        	var row = $('#dgContract').datagrid('getSelected');
	        	if (row == null){
	        		alert('해지할 계약을 선택해 주세요');
	        		return false;
	        	}
	            return $(this).form('validate');
	        },
	        success: function(result){
	            var result = eval('('+result+')');
	            if (result.errorMsg){
	               alert('저장시 에러발생');
	            } else {
	                alert('해지하였습니다.');
	               
	            }
	        }
	    });
	    */
	}
 
    
 
 	// 변경내역산정
    function reqCalcChgContract(){
    	var id = $('#newcontractid').val();
    	$.ajax({
			url : "/customer/getCalcChgContract.do",
			type : "POST",
			dataType : "json",
			data: {
				id: id

			},
			success : function(res){
				var result = res.result;
				if (result == null){
					return;
				}
				
				$('#newcontracttotcareamt_').textbox('setValue', result.totcareamt);
				$('#newcontractaccrentamt_').textbox('setValue', result.accrentamt);
				$('#newcontractdcamt_').textbox('setValue', result.dcamt);
				$('#newcontractcalcamt_').textbox('setValue', result.calcamt);
					
			},
			error: function(xhr, status, thrown) {},
			complete :function(){}
		});
    	
    }
    // 변경신청
    
    function reqChgContract_NotUse(){
    	
    	var saleorgancd = $('#contractsaleorgancd').val();
    	var saleyear = $('#contractsaleyear').val();
    	var seqno = $('#contractseqno').val();
    	
    	var afserviceperiod = $('#chgcaserviceperiod').combobox('getValue');
    	var afqy_py = $('#chgcaqy_py').combobox('getValue');
    	var afprodcd  = $('#chgcaprodcd').combobox('getValue');
    	
    	//var paymentamt = $('#chgcpaymentamt').val(); // 계산정산금액
    	var realcalcamt = $('#chgcrealcalcamt').val(); // 실제정산금액
    	
    	if(isEmpty(saleorgancd)){
    		alert('계약을 선택해 주세요');
    		return;
    	}
    	
    	if(isEmpty(realcalcamt)){
    		alert('실제정산금액을 입력해 주세요');
    		return;
    	}
    	
    	if(isNaN(realcalcamt) == true){
    		alert('실제정산금액은 숫자값만 가능합니다. ');
    		return;
    	}
    	
    	
    	$.ajax({
    			url : "/customer/reqChgContract.do",
    			type : "POST",
    			dataType : "json",
    			data: {
    				event_type: '12',
    				saleorgancd: saleorgancd,
    				saleyear: saleyear,
    				seqno: seqno, 
    				afprodcd: afprodcd,
    				afserviceperiod: afserviceperiod,
    				afqy_py: afqy_py,
    				paymentamt: realcalcamt
    			},
    			success : function(resp){
    				console.log(resp.res);
    				if (resp.res == 'F'){
    					alert('변경신청요청에러');
    					return;
    				}
    				
    				                        
                	$('#dgContract').datagrid({
                		url: '/customer/getContractList.do',
                		queryParams:{
                			custid: g_custid,
                		}
                	});
                	
    				alert('변경신청하였습니다.');	
    			},
    			error: function(xhr, status, thrown) {
    				alert('변경신청요청에러');
    			},
    			complete :function(){		
    			
    			}
    	});
    	
    	
    }
    
    
 
	
 	// 회차추가매니저설정
    function initRecvUser(){
    	$('#recvmanager_id').combogrid({
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
    	    	$('#recvcareorgancd').textbox('setValue', row.organcd);
    	    	$('#recvcareorgannm').textbox('setValue', row.organnm);
    	    }
    	});
    }
 
  	//접수탭 접수정보
	function getRecvList (){
		
		var saleorgancd = $('#contractsaleorgancd').val();
		var saleyear = $('#contractsaleyear').val();
		var seqno = $('#contractseqno').val();
		var custid = g_custid;
		
		$.ajax({
			url : "/customer/getRecvList.do",
			type : "POST",
			dataType : "json",
			data: {
				custid: custid,
				saleorgancd: saleorgancd,
				saleyear: saleyear,
				seqno: seqno
			},
			success : function(response){
				//console.log(response.recvList)
				if (response.recvList != null){
					$('#dgRecv').datagrid({data: response.recvList});  // 접수
				}
			},
			error: function(xhr, status, thrown) {
				
				console.log('접수정보수신시 에러 발생')
			},
			complete :function(){		
				
			}
		});
		
		/* 주의: 아래와 같이 설정하면 추후에 파라미터 값을 바꾸어도 계속 고정값으로 날라간다. 
		// 2018.3.2
		$('#dgRecv').datagrid({
			url: '/customer/getRecvList.do',
			queryParams:{
				custid: custid,
				saleorgancd: saleorgancd,
				saleyear: saleyear,
				seqno: seqno
			}
		});*/
		
		
	}
  
	function initFormContract(){
		$('#newcontractcustid').val(g_custid);
	}
	
	// 계약정보 가져오기
  	function getDgContractList(){
		
  		showTimer();
  		$.ajax({
  			url : "/customer/getContractList.do",
  			type : "POST",
  			dataType : "json",
  			data: {
  				custid: g_custid
  			},
  			success : function(response){
  				if (response.rows != null){
  					$('#dgContract').datagrid({data: response.rows});  
  					$('#dgGeneralContract').datagrid({data: response.rowsGeneral});
  				}else{
  					$('#dgContract').datagrid('loadData', []);  
  					$('#dgGeneralContract').datagrid('loadData', []);  
  				}
  			},
  			error: function(xhr, status, thrown) {
  				
  				console.log('계약정보수신시 에러 발생')
  			},
  			complete :function(){		
  				hideTimer();
  			}
  		});
  	}
	
    function initDgContractList(){
    	// 계약탭
		$('#dgContract').datagrid({
			title: '멤버쉽계약',
			rownumbers: true,
			singleSelect: true,
			height: '200px',			
			columns:[[
		        {field:'id',title:'아이디', hidden:true},
		        {field:'custid',title:'custid', hidden:true},
		        {field:'contractstate',title:'계약상태', hidden:true},
		        {field:'contractstate_',title:'상태'},
		        
		        {field:'contractno',title:'계약ID'},
		        {field:'saleorgancd',title:'판매기관', hidden:true},
		        {field:'saleyear',title:'년도', hidden:true},
		        {field:'seqno',title:'seqno', hidden:true},
		        {field:'prodgroup',title:'분류code', hidden:true},
		        {field:'prodgroup_',title:'분류'},
		        {field:'prodcd',title:'상품명cd', hidden:true},
		        {field:'prodnm',title:'상품명'},
		        
		        {field:'nrulecd',title:'규정', hidden:true},
		        {field:'nrulecd_',title:'규정', hidden:false},
		        
		        
		        {field:'pt_code',title:'패턴code', hidden:true},
		        {field:'pt_code_',title:'패턴', hidden:false},
		        {field:'pay_gb',title:'납부방법cd', hidden:true},
		        {field:'pay_gb_',title:'납부방법', hidden:false},
		        {field:'init_proc_status',title:'최초회차상태', hidden:true},		        
		        {field:'serviceperiod',title:'서비스주기', hidden:false},
		        {field:'qy_py',title:'수량/평형', hidden:false},
		        {field:'carefee',title:'서비스비용', formatter:formatMoney},		        
		        {field:'tot_srv_turn',title:'의무회수', hidden:false},
		        {field:'totcarecnt',title:'총서비스회수', hidden:false},
		        {field:'contractdt',title:'계약일',  formatter:dataGridFormatDate},
		        {field:'conperd_cd',title:'계약기간', hidden:true},
		        {field:'conperd_cd_',title:'계약기간', hidden:false},
		        
		        
		        {field:'saleorgannm',title:'판매기관', hidden:false},
		        {field:'saleuserid',title:'판매자', hidden:true},
		        {field:'saleusernm',title:'판매자', hidden:false},
		        {field:'remarks',title:'특이사항', hidden:true},
		        {field:'file_url',title:'계약서',
		        	formatter: function(value,row,index){
                        if (isEmpty(value)){
                            return value;
                        }else{
                            var callfn = "openDlgContractImageView('{0}')".format(encodeURI(value ));
                            var col = '<a href="javascript:void(0)" onclick="' + callfn  + '">' + '보기' +'</a>';
                            return col;
                        }
                    }
		        },
		        {field:'ordr_no',title:'오더번호', hidden:false},
		       
		        
		        {field:'cmpns_yn',title:'유상cd', hidden:true},
		        
		        {field:'dcrate',title:'할인율', hidden:true},
		        {field:'dcprice',title:'할인금액', hidden:true},
		        {field:'add_product_price',title:'추가금액', hidden:true},
		        
		        {field:'manager_id',title:'매니저', hidden:true},
		        {field:'manager_nm',title:'매니저', hidden:true},
		        {field:'add_manager_id1',title:'매니저1', hidden:true},
		        {field:'add_manager_nm1',title:'매니저1', hidden:true},
		        {field:'add_manager_id2',title:'매니저2', hidden:true},
		        {field:'add_manager_nm2',title:'매니저2', hidden:true},
		        
		        {field:'juminno1',title:'주민번호1', hidden:true},
		        {field:'zipcd',title:'우편번호', hidden:true},
		        
		        {field:'carereqdt',title:'요청날짜', hidden:true},
		        {field:'carereqtime',title:'요청시간', hidden:true},
		        {field:'careendtime',title:'종료시간', hidden:true},
		        
		        {field:'file_id',title:'파일아이디', hidden:true},
		        {field:'file_seq',title:'파일시퀀스', hidden:true},
		        {field:'first_rulecd',title:'최초규정', hidden:true},
		        {field:'first_rulecd_',title:'최초규정', hidden:false},
		        {field:'avail_instant_chg',title:'바로계약변경가능', hidden:true}

			]],
			onDblClickRow : function(index, row){
								
				var custid = row.custid;
				var contract_id = row.contract_id;					
				var saleoragancd = row.saleorgancd;
				var saleyear = row.saleyear;
				var seqno = row.seqno;
				
				if (contract_id == null){
					alert('계약ID가 없습니다.');
					return;
				}
				
				var nrulecd = row.nrulecd;
				console.log('nrulecd:' + nrulecd);
				
				// copy obj
				var nrow = $.extend({}, row);
				openEditContractDlg(nrow);
				
			},
			onClickRow : function(index, row){
				
				// clearSelections
				$('#dgGeneralContract').datagrid('clearSelections');
				
				var custid = row.custid;
				var contract_id = row.contract_id;					
				var saleoragancd = row.saleorgancd;
				var saleyear = row.saleyear;
				var seqno = row.seqno;
				
				
				if (contract_id == null){
					alert('계약ID가 없습니다.');
					return;
				}
				$('#contractsaleorgancd').val(saleoragancd);
				$('#contractsaleyear').val(saleyear);
				$('#contractseqno').val(seqno);
				$('#contractnrulecd').val(row.nrulecd);
				$('#contractcontractstate').val(row.contractstate);
				$('#contractjuminno1').val($('#juminno1').val());
				$('#contractprodgroup').val(row.prodgroup);
				$('#contractprodcd').val(row.prodcd);
				$('#contractprodnm').val(row.prodnm);
				$('#contractzipcd').val(row.zipcd);
				$('#contractpt_code').val(row.pt_code);
				
				
				// 계약에 따른 서비스 정보 가져오기
				getServiceOfContract(custid, saleoragancd, saleyear, seqno);
				
				// 계약변경 / 멤버십일 때와 일반일 때 보여주는 부분 달리하기 
				$('#fmChgContract').form('load',row);
				if (row.nrulecd == 1){
					$('#divChgContractMembership').show();
					$('#divChgContractGeneral').hide();
					
				}else{
					$('#divChgContractMembership').hide();
					$('#divChgContractGeneral').show();
				}
			} // end onclick
		}); // end dgContract datagrid
    }
    
    // 목적: 일반 계약 그리드 초기화
    function initDgGeneralContractList(){
    	// 계약탭
		$('#dgGeneralContract').datagrid({
			title: '일반계약',
			rownumbers: true,
			singleSelect: true,
			height: '200px',			
			columns:[[
		        {field:'id',title:'아이디', hidden:true},
		        {field:'custid',title:'custid', hidden:true},
		        {field:'contractstate',title:'계약상태', hidden:true},
		        {field:'contractstate_',title:'상태'},
		        
		        {field:'contractno',title:'계약ID'},
		        {field:'saleorgancd',title:'판매기관', hidden:true},
		        {field:'saleyear',title:'년도', hidden:true},
		        {field:'seqno',title:'seqno', hidden:true},
		        {field:'prodgroup',title:'분류code', hidden:true},
		        {field:'prodgroup_',title:'분류'},
		        {field:'prodcd',title:'상품명cd', hidden:true},
		        {field:'prodnm',title:'상품명'},
		        
		        {field:'nrulecd',title:'규정', hidden:true},
		        {field:'nrulecd_',title:'규정', hidden:false},
		        
		        
		        {field:'pt_code',title:'패턴code', hidden:true},
		        {field:'pt_code_',title:'패턴', hidden:false},
		        {field:'pay_gb',title:'납부방법cd', hidden:true},
		        {field:'pay_gb_',title:'납부방법', hidden:false},
		        {field:'init_proc_status',title:'최초회차상태', hidden:true},		        
		        {field:'serviceperiod',title:'서비스주기', hidden:false},
		        {field:'qy_py',title:'수량/평형', hidden:false},
		        {field:'carefee',title:'서비스비용', formatter:formatMoney},		        
		        {field:'tot_srv_turn',title:'의무회수', hidden:false},
		        {field:'totcarecnt',title:'총서비스회수', hidden:false},
		        {field:'contractdt',title:'계약일',  formatter:dataGridFormatDate},
		        {field:'conperd_cd',title:'계약기간', hidden:true},
		        {field:'conperd_cd_',title:'계약기간', hidden:false},
		        
		        
		        {field:'saleorgannm',title:'판매기관', hidden:false},
		        {field:'saleuserid',title:'판매자', hidden:true},
		        {field:'saleusernm',title:'판매자', hidden:false},
		        {field:'remarks',title:'특이사항', hidden:true},
		        {field:'file_url',title:'계약서',
		        	formatter: function(value,row,index){
                        if (isEmpty(value)){
                            return value;
                        }else{
                            var callfn = "openDlgContractImageView('{0}')".format(encodeURI(value ));
                            var col = '<a href="javascript:void(0)" onclick="' + callfn  + '">' + '보기' +'</a>';
                            return col;
                        }
                    }
		        },
		        {field:'ordr_no',title:'오더번호', hidden:false},
		       
		        
		        {field:'cmpns_yn',title:'유상cd', hidden:true},
		        
		        {field:'dcrate',title:'할인율', hidden:true},
		        {field:'dcprice',title:'할인금액', hidden:true},
		        
		        {field:'manager_id',title:'매니저', hidden:true},
		        {field:'manager_nm',title:'매니저', hidden:true},
		        {field:'add_manager_id1',title:'매니저1', hidden:true},
		        {field:'add_manager_nm1',title:'매니저1', hidden:true},
		        {field:'add_manager_id2',title:'매니저2', hidden:true},
		        {field:'add_manager_nm2',title:'매니저2', hidden:true},
		        
		        {field:'juminno1',title:'주민번호1', hidden:true},
		        {field:'zipcd',title:'우편번호', hidden:true},
		        
		        {field:'carereqdt',title:'요청날짜', hidden:true},
		        {field:'carereqtime',title:'요청시간', hidden:true},
		        {field:'carendtime',title:'종료시간', hidden:true},
		        
		        {field:'file_id',title:'파일아이디', hidden:true},
		        {field:'file_seq',title:'파일시퀀스', hidden:true},
		        {field:'first_rulecd',title:'최초규정', hidden:true},
		        {field:'first_rulecd_',title:'최초규정', hidden:false},
		        {field:'avail_instant_chg',title:'바로계약변경가능', hidden:true}

			]],
			onDblClickRow : function(index, row){
								
				var custid = row.custid;
				var contract_id = row.contract_id;					
				var saleoragancd = row.saleorgancd;
				var saleyear = row.saleyear;
				var seqno = row.seqno;
				
				if (contract_id == null){
					alert('계약ID가 없습니다.');
					return;
				}
				
				var nrulecd = row.nrulecd;
				
				// copy obj
				var nrow = $.extend({}, row);
				openEditContractDlg(nrow);
				
			},
			onClickRow : function(index, row){
				
				// clearSelections
				$('#dgContract').datagrid('clearSelections');
				
				var custid = row.custid;
				var contract_id = row.contract_id;					
				var saleoragancd = row.saleorgancd;
				var saleyear = row.saleyear;
				var seqno = row.seqno;
				
				
				if (contract_id == null){
					alert('계약ID가 없습니다.');
					return;
				}
				$('#contractsaleorgancd').val(saleoragancd);
				$('#contractsaleyear').val(saleyear);
				$('#contractseqno').val(seqno);
				$('#contractnrulecd').val(row.nrulecd);
				$('#contractcontractstate').val(row.contractstate);
				$('#contractjuminno1').val($('#juminno1').val());
				$('#contractprodgroup').val(row.prodgroup);
				$('#contractprodcd').val(row.prodcd);
				$('#contractprodnm').val(row.prodnm);
				$('#contractzipcd').val(row.zipcd);
				$('#contractpt_code').val(row.pt_code);				
				
				// 계약에 따른 서비스 정보 가져오기
				getServiceOfContract(custid, saleoragancd, saleyear, seqno);
				
				// 계약변경 / 멤버십일 때와 일반일 때 보여주는 부분 달리하기 
				$('#fmChgContract').form('load',row);
				if (row.nrulecd == 1){
					$('#divChgContractMembership').show();
					$('#divChgContractGeneral').hide();
					
				}else{
					$('#divChgContractMembership').hide();
					$('#divChgContractGeneral').show();
				}
			} // end onclick
		}); // end dgContract datagrid
    }
    
    // 접수정보 목록 클리어
    function clearDgRecvList(){
    	$('#dgRecv').datagrid('loadData', []);  
    }
    function initDgRecvList(){
    	$('#dgRecv').datagrid({
			title: '접수정보',
			rownumbers: true,
			singleSelect: true,
			fitColumns: true,
			width: 1200,
			height: 300,
			toolbar: '#toolbar-dgrecv',
		    columns:[[
		        {field:'id',title:'아이디', hidden:true},
		        {field:'care_type',title:'구분', hidden:true},
		        {field:'care_type_',title:'구분'},
		        {field:'nrulecd',title:'규정', hidden:true},
		        {field:'nrulecd_',title:'규정'},
		        {field:'service_turn',title:'회차'},
		        {field:'proc_status',title:'처리상태', hidden:true},
		        {field:'proc_status_',title:'처리상태'},
		        {field:'proc_status_detail',title:'처리상세cd', hidden:true},
		        {field:'proc_status_detail_',title:'처리상세'},
		        {field:'complete_dt',title:'완료일', formatter:dataGridFormatDate}, 
		        {field:'start_time',title:'시작시간', formatter:dataGridFormatTime}, 
		        {field:'end_time',title:'종료시간', formatter:dataGridFormatTime},
		        {field:'updatedt',title:'처리시간', formatter:dataGridFormatDate}, 
		        {field:'carereqdt',title:'예정일', formatter:dataGridFormatDate},
		        {field:'carereqtime',title:'예정시간', formatter:dataGridFormatTime},
		        {field:'service_type_cd',title:'서비스유형', hidden:true},
		        {field:'service_type_cd_',title:'서비스유형'},
		        {field:'carefee',title:'서비스비용', hidden:true}, 
		        {field:'careorgancd',title:'지점', hidden:true},
		        {field:'careorgannm',title:'케어지점'},
		        {field:'prodgroup_',title:'상품그룹명', hidden:true},
		        {field:'manager_id',title:'케어매니저', hidden:true},
		        {field:'manager_mobileno',title:'매니저mobile', hidden:true},
		        {field:'manager_nm',title:'케어매니저', 
		        	formatter: function(value,row,index){			        		
		        		if (row.proc_status == '1' || row.proc_status == '2'){
		        			var callfn = "openManagerSmsModal('{0}', '{1}', '{2}', '{3}', '{4}', '{5}')".format(row.manager_id, row.manager_nm, row.manager_mobileno, 
		        									row.prodgroup_, dataGridFormatDate(row.carereqdt), dataGridFormatTime(row.carereqtime) );
			        		var col = '<a href="javascript:void(0)" onclick="' + callfn  + '">' + value +'</a>';
							return col;
		        		}else{		        			 
							return value;
		        		}
					}
		        },
		        {field:'RCPTORGANCD1_NM',title:'점검지점',
		        	formatter: function(value,row,index) {
		        		// service_info_id, contract_id, rc1p, add_m1
		        		var callfn = "openChangeCareOrg({0},'{1}','{2}','{3}','{4}')".format(row.id, row.contract_id, row.RCPTORGANCD1, row.ADD_MANAGER_ID1,row.proc_status);
						var col = '<a href="javascript:void(0)" onclick="' + callfn  + '">' + value +'</a>';
						return col;
		        	}		
		       	},
		        {field:'ADD_MANAGER_ID1_NM',title:'점검매니저'},
		        {field:'remarks',title:'처리특이사항',
			        formatter: function(value,row,index){			        		
		        		if (row.remarks != ''){
		        			var callfn = "openDlgServiceRemarks('{0}')".format(row.remarks );
			        		var col = '<a href="javascript:void(0)" onclick="' + callfn  + '">' + '케어내용' +'</a>';
							return col;
		        		}else{		        			 
							return value;
		        		}
					}
		        },
		        {field:'fix_manager_yn',title:'고정'},
		        {field:'custsignfile',title:'서명',		        	
		        	formatter: function(value,row,index){
                        if (isEmpty(value)){
                            return value;
                        }else{
                            var callfn = "openDlgContractImageView('{0}')".format(encodeURI(value ));
                            var col = '<a href="javascript:void(0)" onclick="' + callfn  + '">' + '서명보기' +'</a>';
                            return col;
                        }
                    }	        
		        },
		        {field:'work_image_url',title:'결과',		        	
		        	formatter: function(value,row,index){
		        		if (row.proc_status == 3){
		        			var callfn = "openDlgServiceResult('{0}', '{1}', '{2}', '{3}')".format(row.saleorgancd, row.saleyear, row.seqno, row.service_turn );
			        		var col = '<a href="javascript:void(0)" onclick="' + callfn  + '">' + '결과보기' +'</a>';
							return col;
		        		}else{		        			 
							return value;
		        		}
					}		        
		        },
		        {field:'saleorgancd',title:'판매기관', hidden:true},
		        {field:'saleyear',title:'년도', hidden:true},
		        {field:'seqno',title:'번호', hidden:true}
		        
		        
		    ]],
			onClickRow : function(index, row){
        		var row = $('#dgRecv').datagrid('getSelected');
        		if (row){
        			
        			var carereqdt = row.carereqdt;
        			var carereqtime = row.carereqtime;
        			var careendtime = row.careendtime;
        			
        			if (carereqdt !=null && carereqdt.length == 8){
        				var cyyyy = carereqdt.substring(0,4);
	        			var cmm = carereqdt.substring(4,6);
	        			var cdd = carereqdt.substring(6,8);
	        			row.carereqdt = cyyyy + '-' + cmm + '-' + cdd;
        			}
        			
        			if( carereqtime!=null && carereqtime.length == 4){
        				var hh = carereqtime.substring(0,2);
        				var mm = carereqtime.substring(2,4);
        				row.carereqtime = hh + ':' + mm;
        			
        			
        			}
        			
        			if( careendtime!=null && careendtime.length == 4){
        				var hh = careendtime.substring(0,2);
        				var mm = careendtime.substring(2,4);
        				row.careendtime = hh + ':' + mm;
        			}
        			
        			$('#fmAsServiceRecv').form('load', row);	        			
        			
        		}	        		
	        }
	       
		});
    }
    
    function getServiceOfContract(custid, saleoragancd, saleyear, seqno) {
    	
    	$.ajax({			
			url : "/customer/getAsServiceList.do",
			type : "GET",
			dataType : "json",
			data: {
				custid: custid,
				saleorgancd: saleoragancd,
				saleyear: saleyear,
				seqno: seqno
			},
			success : function(response){
				if (response.recvList != null){
					$('#dgRecv').datagrid({data: response.recvList});  // 접수
				}
				setCloseContract();
			
			},
			error: function(xhr, status, thrown) {
				if(xhr != undefined && xhr.status == 500){
					//alertMsg("",xhr.responseText);
				} else {
					//alertMsg("","<spring:message code='msg.occur.network.error' /><br><spring:message code='msg.retry' />");
				}
			},
			complete :function(){ }
		});
    }
    
    function setCloseContract() {
    	// 해지정보설정
//		if (response.closeContract != null){								
//			$('#fmCloseContract').form('load',response.closeContract);	
//		}else{								
//			var closeContract = new Object();
//			closeContract.id = null;								
//			closeContract.saleorgancd = saleoragancd;
//			closeContract.seqno = seqno;
//			closeContract.saleyear = saleyear;
//			closeContract.closereason = null;
//			closeContract.closetype = 1;								
//			$('#fmCloseContract').form('load',closeContract);								
//		}
	
	// 계약변경설정
//		var availInstantChgContract = response.availInstantChgContract;
//		if (availInstantChgContract == 'T'){
//			$('#availInstantChgContract').text('계약변경이 가능합니다');
//		}else{
//			$('#availInstantChgContract').text('정산이 발생합니다');
//		}
//		var joItemDtl = getProdCdByProdGroup(row.prodgroup, 'ALL');
//		$('#chgcbprodcd').combobox({
//			valueField: 'prodcd',
//			textField: 'prodnm',
//			data: joItemDtl
//		});
//		$('#chgcaprodcd').combobox({
//			valueField: 'prodcd',
//			textField: 'prodnm',
//			data: joItemDtl
//		});
	
//		$('#chgcbserviceperiod').combobox('setValue', row.serviceperiod);
//		$('#chgcbqy_py').combobox('setValue', row.qy_py);
//		$('#chgcbprodgroup_').textbox('setValue', row.prodgroup_);
//		$('#chgcbprodcd').combobox('setValue', row.prodcd);
	
//		$('#chgcaserviceperiod').combobox('setValue', row.serviceperiod);
//		$('#chgcaqy_py').combobox('setValue', row.qy_py);
//		$('#chgcaprodgroup_').textbox('setValue', row.prodgroup_);
//		$('#chgcaprodcd').combobox('setValue', row.prodcd);
	

	
	// https://stackoverflow.com/questions/8423812/enable-disable-a-div-and-its-elements-in-javascript
//		if (row.nrulecd == '1'){
//			$('#btnReqCalcChangeContract').linkbutton('enable');
//			$('#btnReqChgContract').linkbutton('enable');
//			$('#btnReqCancelChg').linkbutton('enable');
//			$('#availInstantChgContract').show();
//		}else{
//			$('#btnReqCalcChangeContract').linkbutton('disable');
//			$('#btnReqChgContract').linkbutton('disable');
//			$('#btnReqCancelChg').linkbutton('disable');
//			$('#availInstantChgContract').hide();
//		}
	
//		if (row.contractstate == 5){
//			$('#btnReqCalcChangeContract').linkbutton('disable');
//			$('#btnReqChgContract').linkbutton('disable');
//			$('#btnReqCancelChg').linkbutton('disable');
//			$('#availInstantChgContract').hide();
//		}
    }
    
    // 21. 12. 9 open 점검지점 수정 모달 
    function openChangeCareOrg(id, contractId, rcptoorgancd1, addManager1, procStatus) {
    	if (procStatus != '1' && procStatus != '2') {
    		alert('처리상태가 [등록] [컨택완료] 만 가능합니다.');
    		return false;
    	}
    	var row = {id:id, contract_id: contractId, RCPTORGANCD1: rcptoorgancd1, ADD_MANAGER_ID1:addManager1};
//     	$('#formChangeCareOrg').form('clear');
//     	$('#formChangeCareOrg input:hidden').val('');
    	$('#formChangeCareOrg').form('load', row);
    	$('#dlgChangeCareOrg').dialog('open');
    }
    
 	// 21. 12. 9 점검지점 수정
    function saveChangeCareOrg() {
    	
    	var r = confirm('저장하시겠습니까?');
		if (r != true){
			return;
		}
		
		$('#formChangeCareOrg').form('submit',{
	        url: "/customer/changeCareOrg.do",
	        onSubmit: function(){
	            return $(this).form('validate');
	        },
	        success: function(result){
	            var result = eval('('+result+')');
	            if (result.isSuccess){
	            	alert('저장되었습니다.');
	            	$('#dlgChangeCareOrg').dialog('close');
	            	// dg reload
	            	$('#dgRecv').datagrid('reload');
	            } else {
	                alert(result.message);
	            }
	        }
	    });
    }
 	
 	function refreshServiceInfo() {
 		var row = $('#dgContract').datagrid('getSelected');
		row = (row) ? row : $('#dgGeneralContract').datagrid('getSelected');
		if (!row) {
			alert('선택된 계약정보가 없습니다.')
			return;
		}
 		getServiceOfContract(row.custid, row.saleorgancd, row.saleyear, row.seqno);
 	}
    
 	
 	function getAddProduct(id){ 	   
    	
    	$.ajax({
			url : "/customer/getAddProduct.do",
			type : "POST",
			dataType : "json",
			data: {
				contract_id: id

			},
			success : function(res){
				console.dir(res)
				var str =""
				for(var i=0 ; i < res.productList.length ; i++){
					
					str+=' <div style="margin-bottom:10px" id="addproductbasic">';
					str+=' <input type="hidden" name="addproductid" value ="'+res.productList[i].ID+'">';
					str+=' <label class="textbox-label textbox-label-before" style="text-align: right; height: 27px; line-height: 27px;">추가상품그룹</label>';
					str+=' <select  name="addproductgroup"  id="addproductgroup" class="addpro-combobox" label="추가상품그룹" labelAlign="right" style="width:150px;">';
					str+='<option value="줄눈시공"';
					if(res.productList[i].PRODUCT_GROUP =='줄눈시공'){
						str+=' selected '
					}
					str+='>줄눈시공</option>';
					
					str+='<option value="배관청소"';
					if(res.productList[i].PRODUCT_GROUP =='배관청소'){
						str+=' selected '
					}
					str+='>배관청소</option>';
					str+='<option value="곰팡이제거"';
					if(res.productList[i].PRODUCT_GROUP =='곰팡이제거'){
						str+=' selected '
					}
					str+='>곰팡이제거</option>';
					str+='<option value="결로방지"';
					if(res.productList[i].PRODUCT_GROUP =='결로방지'){
						str+=' selected '
					}
					str+='>결로방지</option>';
					str+='<option value="나노코팅"';
					if(res.productList[i].PRODUCT_GROUP =='나노코팅'){
						str+=' selected '
					}
					str+='>나노코팅</option>';
					str+='<option value="기타"';
					if(res.productList[i].PRODUCT_GROUP =='기타'){
						str+=' selected '
					}
					str+='>기타</option>';
				    	
					str+='</select>'
					str+=' <label class="textbox-label textbox-label-before" for="" style="text-align: right; height: 27px; line-height: 27px;">추가상품명</label>'
					str+=' <input name="addproduct" id="addproduct" class="addpro-input-text"  label="추가상품명" 	 labelAlign="right" style="width:150px" value="'+res.productList[i].PRODUCT_CONTENT +'">'
					str+=' <label class="textbox-label textbox-label-before" for="" style="text-align: right; height: 27px; line-height: 27px;">추가상품가격</label>'
					str+=' <input name="addproductcost" id="addproductcost" class="addpro-input-text" onkeyup="sumAddProduct()" label="추가상품가격" labelAlign="right" style="width:150px" value="'+res.productList[i].PRODUCT_COST +'"numberOnly>'
					str+=' <a href ="javascript:void(0)" class="addp_del" onclick="delAddProductId(this)" ><span class="icon-cancel">&nbsp;</span></a>'
					str+='</div>';
				}
				$("#addproductdiv").append(str);
				addEvent();
			},
			error: function(xhr, status, thrown) {},
			complete :function(){}
		});
 	}
 	
 	
</script>