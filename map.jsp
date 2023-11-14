<%@page import="MMJ.RestaurantInfo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=6sx49ht4ta&submodules=geocoder"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
    <style>
        /* 스타일을 사용하여 지도를 화면 전체 크기로 설정 */
        #map {
            width: 100%;
            height: 100vh;
        }
    </style>
</head>
<body>

<div id="map" class="map-container"></div>

<script>
var markers = []; // 마커를 저장할 배열
var firstMarker = null; // 첫 번째 마커를 따로 저장

<%
    List<RestaurantInfo> restaurantList = (List<RestaurantInfo>) request.getAttribute("restaurantList");
    if (restaurantList != null && !restaurantList.isEmpty()) {
        for (RestaurantInfo restaurant : restaurantList) {
            String address = restaurant.getAddress();
            String title = restaurant.getTitle(); // 가게명
            String link = restaurant.getLink(); // 링크
            String category = restaurant.getCategory(); // 카테고리
%>
var coordinates = "N/A";
naver.maps.Service.geocode({
    query: "<%= address %>"
}, function(status, response) {
    if (status === naver.maps.Service.Status.OK) {
        var item = response.v2.addresses[0];
        coordinates = "Lat: " + item.x + ", Lng: " + item.y;

        // 정보 창에 표시할 내용
        var contentString = '<div style="border: 2px solid #800080; padding: 0; margin: 0;">' +
                            '<h4 style="margin: 0; padding: 0;">' + title + '</h4>' + // 가게명 표시
                            '<p style="margin: 0; padding: 0;">' + category + '</p>' + // 카테고리 표시
                            '<p style="margin: 0; padding: 0;">' + address + '</p>' + // 주소 표시
                            '</div>';

        // 마커 생성 및 지도에 표시
        var marker = new naver.maps.Marker({
            position: new naver.maps.LatLng(item.y, item.x),
            map: map
        });

        // 첫 번째 마커인 경우 중심 위치로 설정
        if (!firstMarker) {
            firstMarker = marker;
            var center = marker.getPosition();
            map.setCenter(center);
        }

        // 정보 창 생성
        var infowindow = new naver.maps.InfoWindow({
            content: contentString,
        });

        // 마커를 클릭했을 때 정보 창 열기
        naver.maps.Event.addListener(marker, "click", function(e) {
            infowindow.open(map, marker);
        });

        // 마커 배열에 추가
        markers.push(marker);

        // (선택) 콘솔에 마커 정보 출력
        console.log("Marker created:", title, item);
    }
});
<%
}
}
%>

var mapOptions = {
        mapTypeControl: true,
        mapTypeControlOptions: {
            style: naver.maps.MapTypeControlStyle.BUTTON,
            position: naver.maps.Position.TOP_RIGHT
        },
        zoomControl: true,
        zoomControlOptions: {
            style: naver.maps.ZoomControlStyle.SMALL,
            position: naver.maps.Position.TOP_RIGHT
        },
        scaleControl: true,
        scaleControlOptions: {
            position: naver.maps.Position.RIGHT_CENTER
        },
        logoControl: true,
        logoControlOptions: {
            position: naver.maps.Position.TOP_LEFT
        },
        mapDataControl: true,
        mapDataControlOptions: {
            position: naver.maps.Position.BOTTOM_LEFT
        }
    };

    // 지도 초기화
    var map = new naver.maps.Map('map', mapOptions);

    // JavaScript Function to Focus on Map
    function focusOnMap(address, title, category) {
	    // Geocode the address to get the coordinates
	    naver.maps.Service.geocode({
	        query: address
	    }, function(status, response) {
	        if (status === naver.maps.Service.Status.OK) {
	            var item = response.v2.addresses[0];
	            var position = new naver.maps.LatLng(item.y, item.x);
	
	            // Pan to the selected location on the map
	            map.panTo(position);
	
	            // Create a marker for the selected location
	            var selectedMarker = new naver.maps.Marker({
	                position: position,
	                map: map,
	                icon: './assests/selected_marker.png' // Add a custom icon for the selected marker
	            });
	
	            // Open an info window for the selected location with restaurant information
	            var selectedContentString = '<div style="border: 2px solid #800080; padding: 0; margin: 0;">' +
	                                        '<h4 style="margin: 0; padding: 0;">' + title + '</h4>' +
	                                        '<p style="margin: 0; padding: 0;">카테고리: ' + category + '</p>' +
	                                        '<p style="margin: 0; padding: 0;">주소: ' + address + '</p>' +
	                                        '</div>';
	
	            var selectedInfowindow = new naver.maps.InfoWindow({
	                content: selectedContentString,
	            });
	
	            selectedInfowindow.open(map, selectedMarker);
	
	            // Close the info window after a few seconds (adjust as needed)
	            setTimeout(function() {
	                selectedInfowindow.close();
	            }, 3000);
	        }
	    });
	}
</script>
</body>
</html>