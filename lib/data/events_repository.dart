  import '../models/model.dart';

abstract class Events {
    Future getEvents();
  }

  class EventRepository implements Events {
    @override
    Future<List<Event>> getEvents() async {
      try {
        final events = await Event().select().toList();
        return events;
      } catch (e) {
        throw Exception('Failed to fetch events: $e');
      }
    }
  }
