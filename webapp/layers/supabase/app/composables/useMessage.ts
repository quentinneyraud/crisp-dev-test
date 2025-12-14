import type { RealtimePostgresInsertPayload } from '@supabase/supabase-js'
import type { Tables } from '@/types/database.types'

export function useMessages(roomId: Ref<Tables<'message'>['id'] | null>) {
  const client = useSupabaseClient()
  const user = useSupabaseUser()

  const messages = ref<Tables<'message'>[]>([])
  let channel: ReturnType<typeof client.channel> | null = null

  async function loadLastMessages() {
    if (!roomId.value || !user.value) return

    const { data, error } = await client
      .from('message')
      .select('id, content, created_by, room_id, created_at')
      .eq('room_id', roomId.value)
      .order('created_at', { ascending: false })
      .limit(10)

    if (error) {
      console.error(error)
      return
    }

    messages.value = (data ?? []).reverse()
  }

  function subscribe() {
    if (!roomId.value || channel) return

    channel = client
      .channel(`messages-${roomId.value}`)
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'message',
          filter: `room_id=eq.${roomId.value}`,
        },
        ({ new: message }: RealtimePostgresInsertPayload<Tables<'message'>>) => {
          messages.value.push(message)
        },
      )
      .subscribe()
  }

  function unsubscribe() {
    if (channel) {
      client.removeChannel(channel)
      channel = null
    }
  }

  async function sendMessage(content: string) {
    if (!roomId.value || !user.value) return

    await client.from('message').insert({
      room_id: roomId.value,
      content,
    })
  }

  watch(roomId, async (newRoom) => {
    unsubscribe()
    messages.value = []

    if (newRoom) {
      await loadLastMessages()
      subscribe()
    }
  }, { immediate: true })

  onBeforeUnmount(() => {
    unsubscribe()
  })

  return {
    messages,
    sendMessage,
  }
}
