class AddPicture < Mongoid::Migration
  def self.up
  	Picture.create(name: "背景1",image_url:"/images/back/1.jpg")
	Picture.create(name: "背景2",image_url:"/images/back/2.jpg")
	Picture.create(name: "背景3",image_url:"/images/back/3.jpg")
	Picture.create(name: "背景4",image_url:"/images/back/4.jpg")
	Picture.create(name: "背景5",image_url:"/images/back/5.jpg")
	Picture.create(name: "背景6",image_url:"/images/back/6.jpg")
	Picture.create(name: "背景7",image_url:"/images/back/7.jpg")
	Picture.create(name: "背景8",image_url:"/images/back/8.jpg")
	Picture.create(name: "背景9",image_url:"/images/back/9.jpg")
	Picture.create(name: "背景10",image_url:"/images/back/10.jpg")
	Picture.create(name: "背景11",image_url:"/images/back/11.jpg")
	Picture.create(name: "背景12",image_url:"/images/back/12.jpg")
	Picture.create(name: "背景13",image_url:"/images/back/13.jpg")
	Picture.create(name: "背景14",image_url:"/images/back/14.jpg")
	Picture.create(name: "背景15",image_url:"/images/back/15.jpg")
	Picture.create(name: "背景16",image_url:"/images/back/16.jpg")
	Picture.create(name: "背景17",image_url:"/images/back/17.jpg")
	Picture.create(name: "背景18",image_url:"/images/back/18.jpg")
	Picture.create(name: "背景19",image_url:"/images/back/19.jpg")
	Picture.create(name: "背景20",image_url:"/images/back/20.jpg")
	Picture.create(name: "背景21",image_url:"/images/back/21.jpg")
	Picture.create(name: "背景22",image_url:"/images/back/22.jpg")
	Picture.create(name: "背景23",image_url:"/images/back/23.jpg")
	Picture.create(name: "背景24",image_url:"/images/back/24.jpg")
	Picture.create(name: "背景25",image_url:"/images/back/25.jpg")
	Picture.create(name: "背景26",image_url:"/images/back/26.jpg")
	Picture.create(name: "背景27",image_url:"/images/back/27.jpg")
	Picture.create(name: "背景28",image_url:"/images/back/28.jpg")
	Picture.create(name: "背景29",image_url:"/images/back/29.jpg")
	Picture.create(name: "背景30",image_url:"/images/back/30.jpg")
	Picture.create(name: "背景31",image_url:"/images/back/31.jpg")
	Picture.create(name: "背景32",image_url:"/images/back/32.jpg")
	Picture.create(name: "背景33",image_url:"/images/back/33.jpg")
	Picture.create(name: "背景34",image_url:"/images/back/34.jpg")
	Picture.create(name: "背景35",image_url:"/images/back/35.jpg")
	Picture.create(name: "背景36",image_url:"/images/back/36.jpg")
	Picture.create(name: "背景37",image_url:"/images/back/37.jpg")
	Picture.create(name: "背景38",image_url:"/images/back/38.jpg")
	Picture.create(name: "背景39",image_url:"/images/back/39.jpg")
	Picture.create(name: "背景40",image_url:"/images/back/40.jpg")
	Picture.create(name: "背景41",image_url:"/images/back/41.jpg")
	Picture.create(name: "背景42",image_url:"/images/back/42.jpg")
	Picture.create(name: "背景43",image_url:"/images/back/43.jpg")
	Picture.create(name: "背景44",image_url:"/images/back/44.jpg")
	Picture.create(name: "背景45",image_url:"/images/back/45.jpg")
	Picture.create(name: "背景46",image_url:"/images/back/46.jpg")
	Picture.create(name: "背景47",image_url:"/images/back/47.jpg")
	Picture.create(name: "背景48",image_url:"/images/back/48.jpg")
	Picture.create(name: "背景49",image_url:"/images/back/49.jpg")
	Picture.create(name: "背景50",image_url:"/images/back/50.jpg")
	Picture.create(name: "背景51",image_url:"/images/back/51.jpg")
	Picture.create(name: "背景52",image_url:"/images/back/52.jpg")
	Picture.create(name: "背景53",image_url:"/images/back/53.jpg")
	Picture.create(name: "背景54",image_url:"/images/back/54.jpg")
	Picture.create(name: "背景55",image_url:"/images/back/55.jpg")
	Picture.create(name: "背景56",image_url:"/images/back/56.jpg")
	Picture.create(name: "背景57",image_url:"/images/back/57.jpg")
	Picture.create(name: "背景58",image_url:"/images/back/58.jpg")
	Picture.create(name: "背景59",image_url:"/images/back/59.jpg")
	Picture.create(name: "背景60",image_url:"/images/back/60.jpg")
  end

  def self.down
  	Picture.delete_all()
  end
end