atom_feed do |feed|
  feed.title params[:holder].present? ? t("main.events_for", holder: Holder.find(params[:holder]).full_name) : t("site_title")
  feed.description t("site_description")
  @events.results.each_with_index do |event|
    feed.entry event, published: event.updated_at, url: show_url(event) do |entry|
      entry.title event.title
      entry.content strip_tags(event.description)
      entry.scheduled event.scheduled
      entry.author do |author|
        author.name event.position.holder.full_name
      end
    end
  end
end
