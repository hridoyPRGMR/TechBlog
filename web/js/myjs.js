function doLike(pid, uid) {
    
    const requestData = {
        uid: uid,
        pid: pid,
        operation: 'like'
    };

    $.ajax({
        url: 'LikeServlet',
        data: requestData,
        success: function(data,textStatus,jqXHR) {
            if(data.trim()==="ok"){
                let c=$(".like-counter").html();
                c++;
                $('.like-counter').html(c);
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log('AJAX Error:', errorThrown);
        }
    });
}

function doUnLike(pid, uid) {
    const requestData = {
        uid: uid,
        pid: pid,
        operation: 'unlike'
    };

    $.ajax({
        url: 'LikeServlet',
        data: requestData,
        success: function(data,textStatus,jqXHR) {
            if (data.trim() === 'ok') {
                let c=$(".like-counter").html();
                c--;
                $('.like-counter').html(c);
            } else {
                console.log('Error: Unexpected response from server');
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log('AJAX Error:', errorThrown);
        }
    });
}
