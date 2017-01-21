
// $(function() {
//   alert("hi");
//     $('.piece').draggable({
//         snap: '.square',
//         snapMode: 'outer',
//         snapTolerance: 40,
//         revert: 'invalid',
//         opacity: 0.20,
//         refreshPositions: true
//     });
//
//     $('.square').droppable({
//         accept: '.piece',
//         drop: function(event, ui) {
//             var originalSquare_id = $(ui.draggable).parent().attr('id');
//             var capturedPiece = $(this).children().attr('id');
//             var piece = $(ui.draggable).attr('id');
//             var row = $(this).attr('row_id');
//             var column = $(this).attr('column_id');
//             var game = <%= current_game.id %>
//
//             console.log("original row and column: " + originalSquare_id );
//             console.log("dropped " + piece + " on " + row + "," + column + " for " + game);
//             console.log("captured piece id : " + capturedPiece)
//
//             $.ajax({
//                 type: 'PUT',
//                 url: '/games/'+game+'/pieces/'+piece,
//                 dataType: 'json',
//                 data: {
//                     x: row,
//                     y: column
//                 },
//                 success: function(data) {
//                   $('#'+capturedPiece).fadeOut("slow");
//                   location.reload();
//                 },
//
//                 error: function(data) {
//                     $('#'+piece).css({'left': 0, 'top': 0});
//                     alert('Invalid Move');
//                     console.log("fail");
//
//                 }
//             });
//         }
//     });
// });
