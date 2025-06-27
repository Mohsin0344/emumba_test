import '../models/model.dart';

abstract class Events {
  Future<List<Event>> getEvents();

  Future<List<Event>> getEventsByDate(DateTime date);

  Future<void> createEvent({
    required String name,
    required String description,
    required String type,
    required DateTime dateTime,
    String? attachment,
  });

  Future<void> updateEvent({
    required int id,
    String? name,
    String? description,
    String? type,
    DateTime? dateTime,
    String? attachment,
  });

  Future<void> deleteEvent(int id);

  Future<List<Event>> getEventsByType(String type);
}

class EventRepository implements Events {
  // Get all events
  @override
  Future<List<Event>> getEvents() async {
    try {
      final events = await Event().select().toList();
      return events;
    } catch (e) {
      throw Exception('Failed to fetch events: $e');
    }
  }

  // Get events on a specific date
  @override
  Future<List<Event>> getEventsByDate(DateTime date) async {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

      final events = await Event()
          .select()
          .dateTime
          .between(startOfDay, endOfDay)
          .toList();

      return events;
    } catch (e) {
      throw Exception('Failed to fetch events by date: $e');
    }
  }

  // Create event (only for future dates)
  @override
  Future<void> createEvent({
    required String name,
    String? description,
    required String type,
    required DateTime dateTime,
    String? attachment,
  }) async {
    if (dateTime.isBefore(DateTime.now())) {
      throw Exception('Event date must be in the future.');
    }

    final event = Event()
      ..name = name
      ..description = description
      ..type = type
      ..dateTime = dateTime
      ..attachment = attachment;

    try {
      await event.save();
    } catch (e) {
      throw Exception('Failed to create event: $e');
    }
  }

  // Update event
  @override
  Future<void> updateEvent({
    required int id,
    String? name,
    String? description,
    String? type,
    DateTime? dateTime,
    String? attachment,
  }) async {
    try {
      final event = await Event().getById(id);
      if (event == null) {
        throw Exception('Event not found');
      }

      if (dateTime != null && dateTime.isBefore(DateTime.now())) {
        throw Exception('Event date must be in the future.');
      }

      event
        ..name = name ?? event.name
        ..description = description ?? event.description
        ..type = type ?? event.type
        ..dateTime = dateTime ?? event.dateTime
        ..attachment = attachment ?? event.attachment;

      await event.save();
    } catch (e) {
      throw Exception('Failed to update event: $e');
    }
  }

  @override
  Future<void> deleteEvent(int id) async {
    try {
      final event = await Event().getById(id);
      if (event != null) {
        await event.delete();
      } else {
        throw Exception('Event not found');
      }
    } catch (e) {
      throw Exception('Failed to delete event: $e');
    }
  }

  @override
  Future<List<Event>> getEventsByType(String type) async {
    try {
      final events = await Event()
          .select()
          .type
          .equals(type)
          .toList();
      return events;
    } catch (e) {
      throw Exception('Failed to fetch events by type: $e');
    }
  }
}
