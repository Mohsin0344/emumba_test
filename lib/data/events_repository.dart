  import '../models/model.dart';

abstract class Event {
    Future getEvents();
  }

  class EventRepository implements Event {
    @override
    Future<List<TableEvent>> getEvents() async {
      try {
        final events = await TableEvent().select().toList();
        return events;
      } catch (e) {
        throw Exception('Failed to fetch events: $e');
      }
    }
  }
