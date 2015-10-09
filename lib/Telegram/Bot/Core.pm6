use HTTP::UserAgent;
use JSON::Tiny;

use Telegram::Bot::User;
 
class Telegram::Bot::Core {
  has $.token;
  has $!http-client = HTTP::UserAgent.new;
  has $!base-endpoint = "https://api.telegram.org";

  enum RequestType <Get Head Post>;

  method !send-request($url, RequestType $request-type) {
    # todo
    given $request-type {
      when RequestType::Get {
        return $.http-client.get($url);
      }
      when RequestType::Post {
        return $.http-client.post($url); # add post parameters
      }
      when RequestType::Head {
        return $.http-client.post($url); # 
      }
    } 
    
  }

  sub build-url($method-name) { "{!.base-endpoint}/bot{!.token}/{$method-name}" }

  method get-me() {
    my $full-url = build-url($.token, "getMe");
    try my $response = $!send-request($full-url, "get");
    if $response.is-success {
      my $user-json = from-json($response.content);
      return User::User.new(
        id => user-json{'id'},
        first-name => user-json{'first-name'},
        last-name => user-json{'last-name'},
        user-name => user-json{'user-name'}
      );
    } else {
      die $response.status-line;
    }
  }

  method get-updates($offset, $limit, $timeout) {

  }

  method set-webhook($url, $certificate) {

  }
  
  method send-message($chat-id, $text, $parse-mode, $disable-web-page-preview, $reply-to-message-id, $reply-markup) {

  }

  method forward-message($chat-id, $from-chat-id, $message-id) {

  }
  
  method send-photo($chat-id, $photo, $caption, $reply-to-message-id, $reply-markup) {

  }

  method send-audio($chat-id, $audio, $duration, $performer, $title, $reply-to-message-id, $reply-markup) {

  }

  method send-document($chat-id, $document, $reply-to-message-id, $reply-markup) {

  }

  method send-sticker($chat-id, $sticker, $reply-to-message-id, $reply-markup) {

  }

  method send-video($chat-id, $video, $duration, $caption, $reply-to-message-id, $reply-markup) {

  }

  method send-voice($chat-id, $voice, $duration, $reply-to-message-id, $reply-markup) {

  }

  method send-location($chat-id, $latitude, $longitude, $reply-to-message-id, $reply-markup) {

  }

  method send-chat-action($chat-id, $action) {

  }

  method get-user-profile-photos($user-id, $offset, $limit) {

  }

  method get-file($file-id) {

  }



}