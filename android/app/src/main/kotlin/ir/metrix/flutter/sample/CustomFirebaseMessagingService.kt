package ir.metrix.flutter.sample

import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import ir.metrix.notification.MetrixNotification

class CustomFirebaseMessagingService : FirebaseMessagingService() {

    override fun onMessageReceived(message: RemoteMessage) {
        if (MetrixNotification.onMessageReceived(message)) return
        // here you can process your own fcm messages
    }
}