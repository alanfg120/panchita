export interface MensajePush {
  notification: Notification;
  priority: string;
  data: Data;
  to: string;
  android:Setting
}

interface Notification {
  body: string;
  title: string;
}
interface Data {
  click_action: string;
  mensaje: string;
  event: string;
  id:string
}

interface Setting {
  notification: {
    sound: string;
  };
}
